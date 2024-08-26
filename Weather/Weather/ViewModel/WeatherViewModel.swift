//
//  File.swift
//  WeatherViewModel
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation
import CoreLocation
import Combine
import MapKit

@MainActor public class WeatherViewModel: ObservableObject {
    
    var weatherNetworkService: any WeatherNetworkService
    var locationNetworkService: any LocationNetworkService

    weak var locationManager: LocationManager?
    
    @Published var locationDetails : [Location]?
    @Published var selectedCoordinate: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var annotations : [LocationWrapper] = []
    
    @Published var weather : Weather?
    @Published var forecastDetails : Forecast?
    @Published var hourDetails: [ForecastData] = [ForecastData]()
    @Published var dailyDetails: [DailyForecast] = [DailyForecast]()
    
    @Published var isLoading: Bool = false
    @Published var userLocationLoading: Bool = false
    @Published var forecastLoading: Bool = false
    @Published var weatherLoading: Bool = false
    private var cancellable = Set<AnyCancellable>()

    // Injecting weather and location api service dependencies
    init(weatherNetworkService: any WeatherNetworkService = WeatherNetworkServiceProvider(),
         locationNetworkService: any LocationNetworkService = LocationNetworkServiceProvider(),
         locationManager: LocationManager? = nil) {
        self.weatherNetworkService = weatherNetworkService
        self.locationNetworkService = locationNetworkService
        self.locationManager = locationManager
        subscribeForLoading()
    }
    
    func getWeather(lat: String, long: String) async throws -> Weather {
        try await weatherNetworkService.getWeather(lat: lat, long: long)
    }

    func getForecast(lat: String, long: String) async throws -> Forecast {
        try await weatherNetworkService.getForecast(lat: lat, long: long)
    }
    
    private func subscribeForLoading() {
        $userLocationLoading
            .combineLatest($weatherLoading)
            .combineLatest($forecastLoading)
            .receive(on: DispatchQueue.main)
            .map { (($0.0, $0.1), $1) }
            .sink { [weak self] value in
                guard let self = self else { return }
                let ((userLocationLoading, weatherLoading), forecastLoading) = value
                self.isLoading = userLocationLoading || weatherLoading || forecastLoading
            }.store(in: &cancellable)
    }

    func fetchWeatherData() {
        Task {
            do {
                try await fetchData()
            } catch let error {
                debugPrint("Data fetching failed: \(error.localizedDescription)")
            }
            configureMap()
        }
    }
    
    func fetchData() async throws {
        // This is a common error handler for location, weather and forecast APIs.
        do {
            self.locationDetails = try await self.getLocationDetails()
            self.weather = try await self.getWeatherData()
            self.forecastDetails = try await self.getForecastDetails()
        } catch let error {
            debugPrint("Handle \(error.localizedDescription) here")
        }
        self.hourDetails = self.forecastDetails?.hourly ?? []
        self.dailyDetails = self.forecastDetails?.daily ?? []
    }
    
    // Helper function to set map's region.
    func configureMap() {
        let coordinates = getCoordinates()
        let locationCoordinate = CLLocationCoordinate2D(latitude: Double(coordinates.0) ?? 0.0, longitude: Double(coordinates.1) ?? 0.0)
        annotations = [ LocationWrapper(coordinate: locationCoordinate)]
        self.region = MKCoordinateRegion(center: locationCoordinate, span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0))
    }


}

//MARK: - Coordinates
extension WeatherViewModel {
    // Individual errors are handled in a common place in WeatherView
    func getLocationDetails() async throws -> [Location] {
        userLocationLoading = true
        let latLongs = getCoordinates()
        let locationDetails = try await locationNetworkService.getLocation(lat: latLongs.0, long: latLongs.0)
        self.userLocationLoading = false
        return locationDetails
    }
    
    // Returns current location from locat
    func getCoordinates() -> (String, String) {
        var latitude: Double = locationManager?.currentLocation?.coordinate.latitude ?? 0
        var longitude: Double = locationManager?.currentLocation?.coordinate.longitude ?? 0
        if let coordinates = selectedCoordinate {
            latitude = coordinates.latitude
            longitude = coordinates.longitude
        }
        return (String(latitude), String(longitude))
    }
}

//MARK: - weather
extension WeatherViewModel {
    // Individual errors are handled in a common place in WeatherView
     func getWeatherData() async throws -> Weather {
        weatherLoading = true
        let coordinates = getCoordinates()
        let weather = try await weatherNetworkService.getWeather(lat:  coordinates.0, long:  coordinates.1)
        self.weatherLoading = false
        return weather
    }
}

//MARK: - Forecast
extension WeatherViewModel {
    // Individual errors are handled in a common place in WeatherView
     func getForecastDetails() async throws -> Forecast {
        forecastLoading = true
        let coordinates = getCoordinates()
        let forecastDetails = try await weatherNetworkService.getForecast(lat: coordinates.0, long: coordinates.1)
        self.forecastLoading = false
        return forecastDetails
    }
}


//MARK: - View Helpers
extension WeatherViewModel {
    // Gives 2x version URL as a string for a given imageName string.
    func getImageURL(imageName: String)-> String {
        return NetworkConstants.downloadImageAPIEndpoint + imageName +  "@2x.png"
    }
    
    // Helper function to get min and max temperatures.
    func getMinMaxTemperature(item: DailyForecast) -> (Double, Double) {
        guard let temp = item.temp else { return (0, 0) }
        return ((temp.min ?? 0) , (temp.max ?? 0))
    }
    
    // Returns time value (ex: 11AM) string for a given timestamp.
    func getHourFromTimestamp(timeStamp : Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "hh a"
        var hour = dayTimePeriodFormatter.string(from: date)
        hour = hour.replacingOccurrences(of: " ", with: "")
        hour = hour.removingPrefixes(["0"])
        return hour
    }
    
    // Returns day value (ex: Thu) string for a given timestamp.
    func getDayNameFromTimeStamp(timeStamp : Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEE"
        return dayTimePeriodFormatter.string(from: date)
    }
}
