//
//  LocationViewModel.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

struct LocationViewModel {
    var locationNetworkService: any LocationNetworkService
    
    // Inject network call service dependency
    init(locationNetworkService: any LocationNetworkService) {
        self.locationNetworkService = locationNetworkService
    }
    
    func getLocation(search searchString: String) async throws -> [Location] {
        try await locationNetworkService.getLocation(search: searchString)
    }
    func getLocation(lat: String, long: String) async throws -> [Location] {
        try await locationNetworkService.getLocation(lat: lat, long: long)
    }
}
