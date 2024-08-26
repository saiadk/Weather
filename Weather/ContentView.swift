//
//  ContentView.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/22/24.
//

import SwiftUI

/* I did code in SwiftUI in the interest of time. */
struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @StateObject var screenViewModel = WeatherViewModel()

    var body: some View {
        // Check for location authorization status before launching the main view.
        if locationManager.authorizationStatus != .notDetermined &&
            locationManager.authorizationStatus != .restricted {
            
            // Dependencies injected as environment objects so that all the internal independent views have access to them by default.
            WeatherView()
                .environmentObject(screenViewModel)
                .environmentObject(locationManager)
        } else {
            Text("Please grant location services permission to use the app.")
        }
    }
}

#Preview {
    ContentView()
}
