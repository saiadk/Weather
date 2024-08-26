//
//  LocationCache.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

protocol LocationCacheable {
    func cache(latitude: Double, longitude: Double)
    func getCachedLocation() -> (latitude: Double, longitude: Double)?
    func clearCache()
}

struct LocationCache: LocationCacheable {
    static let shared = LocationCache()
    
    private let defaults = UserDefaults.standard
    
    private let latitudeKey = "CachedLatitude"
    private let longitudeKey = "CachedLongitude"
    
    func cache(latitude: Double, longitude: Double) {
        defaults.set(latitude, forKey: latitudeKey)
        defaults.set(longitude, forKey: longitudeKey)
    }
    
    func getCachedLocation() -> (latitude: Double, longitude: Double)? {
        guard let latitude = defaults.object(forKey: latitudeKey) as? Double,
              let longitude = defaults.object(forKey: longitudeKey) as? Double else {
            return nil
        }
        return (latitude, longitude)
    }
    
    func clearCache() {
        defaults.removeObject(forKey: latitudeKey)
        defaults.removeObject(forKey: longitudeKey)
    }
}
