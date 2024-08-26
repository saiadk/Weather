//
//  WeatherNetworkService.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

// Weather Forecast service
protocol WeatherNetworkService: NetworkDataFetchable {
    func getWeather(lat: String, long: String)  async throws -> Weather
    func getForecast(lat: String, long: String)  async throws -> Forecast
}

// Weather Forecast service provider definition
struct WeatherNetworkServiceProvider: WeatherNetworkService {
    func getWeather(lat: String, long: String)  async throws -> Weather {
        try await fetch(from: getWeatherForecastURL(baseURL: NetworkConstants.weatherAPIEndpoint, lat: lat, long: long))
    }
    
    func getForecast(lat: String, long: String)  async throws -> Forecast {
        try await fetch(from: getWeatherForecastURL(baseURL: NetworkConstants.forecastAPIEndpoint, lat: lat, long: long))
    }
    
    // This is a helper function to append required query string items to the baseURL
    func getWeatherForecastURL(baseURL: String, lat: String, long: String) -> String {
        baseURL + "?" +
        QueryParameters.lat + lat +
        QueryParameters.lon + long +
        QueryParameters.appId + NetworkConstants.apiKey +
        QueryParameters.units + QueryParameters.unitsValue
    }
}

