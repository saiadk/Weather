//
//  LocationCacheTests.swift
//  WeatherTests
//
//  Created by Sai Mangaraju on 8/26/24.
//

import XCTest
import CoreLocation
@testable import Weather

final class LocationCacheTests: XCTestCase {

    var locationCache: LocationCacheable!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        locationCache = LocationCache()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        locationCache = nil
    }

    func testGetCachedLocation() throws {
        var cachedLocation = locationCache.getCachedLocation()
        XCTAssertNil(cachedLocation)
        let location = CLLocation(latitude: -22.963451, longitude: -43.198242)
        locationCache.cache(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        cachedLocation = locationCache.getCachedLocation()
        XCTAssertEqual(cachedLocation?.latitude, location.coordinate.latitude)
        XCTAssertEqual(cachedLocation?.longitude, location.coordinate.longitude)
    }
    
    func testCacheClearing() throws {
        let location = CLLocation(latitude: -22.963451, longitude: -43.198242)
        locationCache.cache(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        var cachedLocation = locationCache.getCachedLocation()
        XCTAssertNotNil(cachedLocation)
        locationCache.clearCache()
        cachedLocation = locationCache.getCachedLocation()
        XCTAssertNil(cachedLocation)
    }
}
