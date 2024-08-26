//
//  StringExtensions.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation
import Combine

@MainActor class SearchViewModel: ObservableObject {
    
    @Published var searchResults: [Location] = []
    @Published var searchLocationLoading: Bool = false
    
    let locationNetworkService: any LocationNetworkService
    let searchQueryPublisher =  PassthroughSubject<String, Never>.init()
    private var cancellables = Set<AnyCancellable>()
    
    init(locationNetworkService: any LocationNetworkService = LocationNetworkServiceProvider()) {
        self.locationNetworkService = locationNetworkService
        subscribeForQueryPublisher()
    }
    
    func searchLocations(search: String) {
        Task {
            searchLocationLoading = true
            self.searchResults =  try await locationNetworkService.getLocation(search: search)
            self.searchLocationLoading = false
        }
    }
    
    func subscribeForQueryPublisher() {
        searchQueryPublisher
            .removeDuplicates()
            .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] query in
                self?.searchLocations(search: query)
            }.store(in: &cancellables)
    }
}
