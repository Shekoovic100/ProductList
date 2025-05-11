//
//  NetworkError.swift
//  ProductListTask
//
//  Created by sherif on 10/05/2025.
//

import Foundation


enum NetworkError: Error, LocalizedError  {
    case noInternet
    case invalidURL
    case noData
    case networkError(Error)
    case decodingError
             
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .noInternet:
            return "No internet connection"
        case .networkError(let error):
                  return "Network error: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to decode data"
        }
    }
}
