//
//  Location.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

struct Location: Decodable, Hashable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
