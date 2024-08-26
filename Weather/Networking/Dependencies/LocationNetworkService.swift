//
//  LocationNetworkService.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

protocol LocationNetworkService: NetworkDataFetchable {
    func getLocation(search: String) async throws -> [Location]
    func getLocation(lat: String, long: String) async throws -> [Location]
}

struct LocationNetworkServiceProvider: LocationNetworkService {
    typealias T = [Location]
    
    func getLocation(search: String) async throws -> T {
        try await fetch(from: getLocationURL(search: search))
    }
    func getLocation(lat: String, long: String) async throws -> T {
        try await fetch(from: getLocationURL(lat: lat, long: long))
    }
}


extension LocationNetworkService {
    
    func getLocationURL(search: String) -> String {
        NetworkConstants.locationSearchAPIEndpoint + "?" + QueryParameters.query + search + QueryParameters.limit + NetworkConstants.locationsResultLimit + QueryParameters.appId + NetworkConstants.apiKey
    }
    
    func getLocationURL(lat: String, long: String) -> String {
        NetworkConstants.locationLatLonAPIEndpoint + "?" + QueryParameters.lat + lat + QueryParameters.lon + long + QueryParameters.appId + NetworkConstants.apiKey
    }
    
}
