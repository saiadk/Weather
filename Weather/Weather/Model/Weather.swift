//
//  Weather.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

struct Weather : Decodable {
    var name: String?
    var main: MainData?
    var weather: [WeatherData]?
}

struct WeatherData : Decodable  {
    var description: String?
    var main: String?
    var icon: String?
}

struct MainData : Decodable  {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var humidity: Double?
}
