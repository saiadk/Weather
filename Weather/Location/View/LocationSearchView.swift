//
//  StringExtensions.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
    
    @State private var searchQuery = ""
    @Binding var isPresented: Bool
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @StateObject var viewModel = SearchViewModel()
    
    init(selectedCoordinate: Binding<CLLocationCoordinate2D?>,
         isPresented: Binding<Bool>) {
        _isPresented = isPresented
        _selectedCoordinate = selectedCoordinate
    }
    
    var body: some View {
        VStack {
            LocationSearchBar(searchQuery: $searchQuery)
                .onChange(of: searchQuery, { oldValue, newValue in
                    viewModel.searchQueryPublisher.send(newValue)
                })
            List(viewModel.searchResults, id: \.self) { result in
                Button(action: {
                    
                    selectedCoordinate = CLLocationCoordinate2D(latitude: result.lat, longitude: result.lon)
                    isPresented = false
                }) {
                    VStack(alignment: .leading) {
                        Text(result.name)
                            .font(.headline)
                        Text("\(result.state), \(result.country)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
}


