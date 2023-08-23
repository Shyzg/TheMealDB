//
//  WebService.swift
//  TheMealDB
//
//  Created by Shyzago on 23/08/23.
//

import Foundation

class Webservice {
    /// Performs an asynchronous network request to fetch data from a URL
    /// - Parameters:
    ///   - url: The URL to fetch the data from
    ///   - parse: A closure that parses the received data and returns the result
    /// - Returns: The parsed result of type `T`
    func get<T: Decodable>(url: URL, parse: @escaping (Data) throws -> T?) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NetworkError.badRequest
        }
        
        guard let result = try parse(data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
    
    /// Enumeration representing network-related errors
    enum NetworkError: Error {
        //case invalidURL
        case badRequest
        case decodingError
    }
}
