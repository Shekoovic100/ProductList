//
//  RemoteProductDataSource.swift
//  ProductListTask
//
//  Created by sherif on 11/05/2025.
//

import Foundation

protocol RemoteProductDataSourceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

class RemoteProductDataSource: RemoteProductDataSourceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        networkService.fetchProducts(completion: completion)
    }
}
