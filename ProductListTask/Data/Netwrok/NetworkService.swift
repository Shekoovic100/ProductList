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
        }.resume()
    }
    
}
