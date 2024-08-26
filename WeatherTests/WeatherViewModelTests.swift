//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Sai Mangaraju on 8/25/24.
//

import XCTest
@testable import Weather

// Covered few test cases in the interest of time.
final class WeatherViewModelTests: XCTestCase {

    var weatherViewModel: WeatherViewModel!
    
    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        weatherViewModel = WeatherViewModel(weatherNetworkService: MockWeatherNetworkServiceProvider(),
                                            locationNetworkService: MockLocationNetworkServiceProvider())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherViewModel = nil
    }

    @MainActor func testData() async throws {
        _ = try await weatherViewModel.fetchData()
        await MainActor.run {
            XCTAssertNotNil(weatherViewModel.weather)
            XCTAssertNotNil(weatherViewModel.locationDetails)
            XCTAssertNotNil(weatherViewModel.forecastDetails)
            XCTAssertNotNil(weatherViewModel.dailyDetails)
            XCTAssertNotNil(weatherViewModel.hourDetails)
        }
    }

    func testWeatherData() async throws {
        let weather = try await weatherViewModel.getWeather(lat: "32.919401", long: "-96.962874")
        XCTAssertNotNil(weather)
    }

    func testForecastData() async throws {
        let forecast = try await weatherViewModel.getForecast(lat: "32.919401", long: "-96.962874")
        XCTAssertNotNil(forecast)
        XCTAssertNotNil(forecast.current)
        await MainActor.run {
            XCTAssertNotNil(weatherViewModel.dailyDetails)
            XCTAssertNotNil(weatherViewModel.hourDetails)
        }
    }
    
    func testLocationData() async throws {
        let locations = try await weatherViewModel.getLocationDetails()
        XCTAssertFalse(locations.isEmpty)
    }
    
    @MainActor func testIconURLs() {
        let testImageURL = weatherViewModel.getImageURL(imageName: "testImage")
        XCTAssertEqual(NetworkConstants.downloadImageAPIEndpoint, "https://openweathermap.org/img/wn/")
        XCTAssertEqual(NetworkConstants.downloadImageAPIEndpoint + "testImage@2x.png", testImageURL)
    }
    
    @MainActor func testDayForecastMinMaxTemperature() async throws {
        _ = try await weatherViewModel.fetchData()
        if let item = weatherViewModel.dailyDetails.first {
            await MainActor.run {
                let dayForecast = weatherViewModel.getMinMaxTemperature(item: item)
                XCTAssertEqual(dayForecast.0, 27.190000000000001)
                XCTAssertEqual(dayForecast.1, 50.490000000000002)
            }
        }
    }

    @MainActor func testHourForecastTimeFormat() {
        let hourForecastTimestamp = weatherViewModel.getHourFromTimestamp(timeStamp: 1685030400)
        XCTAssertEqual(hourForecastTimestamp, "11AM")
    }
    
    @MainActor func testHourForecastDayNameFormat() {
        let dayName = weatherViewModel.getDayNameFromTimeStamp(timeStamp: 1685030400)
        XCTAssertEqual(dayName, "Thu")
    }
}
