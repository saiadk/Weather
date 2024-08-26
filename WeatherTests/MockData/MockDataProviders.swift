//
//  MockDataProviders.swift
//  WeatherUITests
//
//  Created by Sai Mangaraju on 8/26/24.
//

import Foundation
@testable import Weather

enum MockDataError: Error {
    case unableToLoadData
}

class Utils {
    // This method is used to get data from a json file
    func loadData(_ fileName: String) -> Data? {
        let errorMsg = "Bad or corrupt JSON for \(fileName).json"
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: fileName, withExtension: "json"),
              let data = NSData(contentsOf: fileURL) as Data? else {
            print(errorMsg)
            return nil
        }
        return data
    }
}


public struct MockWeatherNetworkServiceProvider: WeatherNetworkService {
    public func getWeather(lat: String, long: String) async throws -> Weather {
        guard let weatherData = Utils().loadData("WeatherForecast") else {
            throw MockDataError.unableToLoadData
        }
        return try JSONDecoder().decode(Weather.self, from: weatherData)
    }
    
    public func getForecast(lat: String, long: String) async throws -> Forecast {
        guard let weatherData = Utils().loadData("WeatherForecast") else {
            throw MockDataError.unableToLoadData
        }
        return try JSONDecoder().decode(Forecast.self, from: weatherData)
    }
}

struct MockLocationNetworkServiceProvider: LocationNetworkService {
    func getLocation(search: String) async throws -> [Location] {
        guard let weatherData = Utils().loadData("Locations") else {
            throw MockDataError.unableToLoadData
        }
        return try JSONDecoder().decode([Location].self, from: weatherData)
    }
    
    func getLocation(lat: String, long: String) async throws -> [Location] {
        guard let weatherData = Utils().loadData("Locations") else {
            throw MockDataError.unableToLoadData
        }
        return try JSONDecoder().decode([Location].self, from: weatherData)
    }
}
