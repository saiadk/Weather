//
//  StringExtensions.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import SwiftUI

/* LocationSearchBar is wrapper type for UIKit UISearchBar to use in the LocationSearchView SwiftUI counterpart. */
struct LocationSearchBar: UIViewRepresentable {
    @Binding var searchQuery: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var searchQuery: String

        init(searchQuery: Binding<String>) {
            _searchQuery = searchQuery
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchQuery = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(searchQuery: $searchQuery)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search for a city"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchQuery
    }
}
