//
//  MockProductRepository.swift
//  ProductListTaskTests
//
//  Created by sherif on 11/05/2025.
//

import Foundation

import Foundation
@testable import ProductListTask

class MockProductRepository: ProductRepositoryProtocol {
    var productsToReturn: [Product] = []
    var errorToReturn: NetworkError?
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        if let error = errorToReturn {
            completion(.failure(error))
        } else {
            completion(.success(productsToReturn))
        }
    }
}
