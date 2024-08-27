//
//  NetworkService.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation

protocol NetworkDataFetchable {
    func fetch<T: Decodable>(from urlString: String) async throws -> T
}

// Default definition to the protocol requirements
extension NetworkDataFetchable {
    func fetch<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else  {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}

