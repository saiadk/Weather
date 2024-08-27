//
//  MapView.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation
import SwiftUI
import MapKit


/* I would have refactored MapView logic to migrate to the newer APIs from deprecated ones, if time permits */

struct MapView: View {
    @EnvironmentObject var screenViewModel: WeatherViewModel
    @State private var position: MapCameraPosition = .automatic
    
    let rect = MKMapRect(
        origin: MKMapPoint(newyork),
        size: MKMapSize(width: 1, height: 1)
    )
    
    var body: some View {
        let weather = screenViewModel.weather
        let temperature = "\((weather?.main?.temp != nil ? (String(Int(weather?.main?.temp ?? 0)) + "°") : "--"))"
        ZStack {
            
            Map( position: $position,
                 bounds: MapCameraBounds(
                    centerCoordinateBounds: MKMapRect(
                        origin: MKMapPoint(screenViewModel.selectedCoordinate ?? newyork),
                        size: MKMapSize(width: 100, height: 100)
                    ),
                    minimumDistance: 25,
                    maximumDistance: .infinity
                    ),
                    interactionModes: .all ) {
                        Annotation(screenViewModel.weather?.name ?? "", coordinate: screenViewModel.selectedCoordinate ?? newyork) {
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 50, height: 50)
        
                                Text(temperature)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .onAppear {
                        position = .region(screenViewModel.region)
                    }
                    .cornerRadius(10)
            
        }.onAppear(perform: {
            screenViewModel.configureMap()
        })
    }
}

// Default fallback location coordinates
let newyork = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)

