//
//  FetchProductUseCase.swift
//  ProductListTaskTests
//
//  Created by sherif on 11/05/2025.
//

import Foundation

@testable import ProductListTask

class MockFetchProductsUseCase: FetchProductsUseCaseProtocol {
    var productsToReturn: [Product] = []
    var errorToReturn: NetworkError?
    
    func execute(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        if let error = errorToReturn {
            completion(.failure(error))
        } else {
            completion(.success(productsToReturn))
        }
    }
}
