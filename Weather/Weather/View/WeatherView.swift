//
//  WeatherView.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import SwiftUI
import MapKit

struct WeatherView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var screenViewModel: WeatherViewModel

    @State var isShowingLocation = false
    @State var selectedCoordinate: CLLocationCoordinate2D?
    var locationCache: LocationCacheable = LocationCache()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .blue, .cyan]), startPoint: .topLeading, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            if screenViewModel.isLoading {
                ProgressView()
            } else {
                if  screenViewModel.weather != nil  &&
                    screenViewModel.locationDetails != nil  {
                    VStack {
                        WeatherSearchView(isShowingLocation: $isShowingLocation)
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .center) {
                                
                                WeatherHeaderView()
                                
                                HoursForecastView()
                                    .frame(height: 180)
                                    .padding(20)
                               
                                DailyForecastView()
                                    .frame(maxHeight: .infinity)
                                    .padding(20)
                                
                                if #available(iOS 17, *) {
                                    MapView()
                                        .frame(height: 250)
                                        .padding(20)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            if let cachedLocation = locationCache.getCachedLocation() {
                selectedCoordinate = CLLocationCoordinate2D(latitude: cachedLocation.latitude, longitude: cachedLocation.longitude)
                screenViewModel.selectedCoordinate = selectedCoordinate
            }
            self.screenViewModel.locationManager = self.locationManager
            checkLocationStatusAndCallAPIs()
        }
        .sheet(isPresented: $isShowingLocation) {
            LocationSearchView(selectedCoordinate: $selectedCoordinate, isPresented: $isShowingLocation)
        }
        .onChange(of: isShowingLocation, { oldValue, newValue in
            if !newValue {
                if let coordinate = selectedCoordinate {
                    screenViewModel.selectedCoordinate = coordinate
                    locationCache.cache(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    Task {
                        try await screenViewModel.fetchData()
                    }
                }
            }
        })
        .onChange(of: locationManager.authorizationStatus, { oldValue, newValue in
            checkLocationStatusAndCallAPIs()
        })
    }
    
    private func checkLocationStatusAndCallAPIs() {
        if locationCache.getCachedLocation() == nil {
            if let locationAuthStatus = locationManager.authorizationStatus, locationAuthStatus != .notDetermined && locationAuthStatus != .restricted {
                isShowingLocation.toggle()
            }
        } else {
            self.screenViewModel.fetchWeatherData()
        }
    }
}

struct LocationWrapper: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
