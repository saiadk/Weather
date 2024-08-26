//
//  Forecast.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

struct Forecast: Decodable {
    var current: ForecastData?
    var hourly: [ForecastData]?
    var daily: [DailyForecast]?
}

struct ForecastData: Decodable {
    var dt: Double?
    var temp: Double?
    var pressure: Double?
    var humidity: Double?
    var weather: [WeatherData]?
}

struct DailyForecast: Decodable {
    var dt: Double?
    var pressure: Double?
    var humidity: Double?
    var weather: [WeatherData]?
    var temp: Temperature?
}

struct Temperature: Decodable {
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
}
