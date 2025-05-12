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
    case serverError(statusCode: Int)
    case unauthorized
    case notFound
    
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
        case .serverError(statusCode: let statusCode):
            return "Server error with Status Code: \(statusCode)"
        case .unauthorized:
            return "Unauthorized access"
        case .notFound:
            return "Resource not found."
        }
    }
}
