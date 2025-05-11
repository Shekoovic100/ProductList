//
//  ProductRepository.swift
//  ProductListTask
//
//  Created by sherif on 11/05/2025.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

class ProductRepository: ProductRepositoryProtocol {
    private let remoteDataSource: RemoteProductDataSourceProtocol
    
    init(remoteDataSource: RemoteProductDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        remoteDataSource.fetchProducts { result in
            switch result {
            case .success(let products):
                print("All \(products.count) products Fetched")
                completion(.success(products))
            case .failure(let error):
                print("Repository error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
