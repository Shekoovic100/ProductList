//
//  NetworkService.swift
//  ProductListTask
//
//  Created by sherif on 10/05/2025.
//

import Foundation
import Network


protocol NetworkServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void)
}


class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://fakestoreapi.com/products"
    private var isConnected = true
    
    let networkMonitor: NetworkMonitor
    
    init(networkMonitor: NetworkMonitor = .shared) {
        self.networkMonitor = networkMonitor
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        
        guard networkMonitor.isConnected else {
            completion(.failure(.noInternet))
            return
        }
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, URLResponse, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = URLResponse as? HTTPURLResponse else {
                completion(.failure(.serverError(statusCode: 0)))
                return
            }
            switch httpResponse.statusCode {
                
            case 200:
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(.decodingError))
                }
            case 401 , 403:
                completion(.failure(.unauthorized))
            case 404:
                completion(.failure(.notFound))
            case 500...599:
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
            default:
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
            }
            
            
        }.resume()
    }
    
}
