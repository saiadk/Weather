//
//  NetworkConstants.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

struct NetworkConstants {
    static let apiKey: String = "7431d52d8f6a5e27f85b81c3248e2f5d" //"6cd9f45b3d108dd49bab57e023c897ff"
    static let locationsResultLimit = "3"

    // API endpoints
    // Location
    static let locationSearchAPIEndpoint = "https://api.openweathermap.org/geo/1.0/direct"
    static let locationLatLonAPIEndpoint = "https://api.openweathermap.org/geo/1.0/reverse"
    // Weather
    static let weatherAPIEndpoint = "https://api.openweathermap.org/data/2.5/weather"
    static let forecastAPIEndpoint = "https://api.openweathermap.org/data/3.0/onecall"
    // Icons
    static let downloadImageAPIEndpoint = "https://openweathermap.org/img/wn/"
}

struct QueryParameters {
    static let query = "q="
    static let limit = "&limit="
    static let appId = "&appid="
    static let lat = "lat="
    static let lon = "&lon="
    static let units = "&units="
    static let unitsValue = "imperial"
}
