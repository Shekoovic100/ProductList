//
//  FetchProductsUseCase.swift
//  ProductListTask
//
//  Created by sherif on 11/05/2025.
//

import Foundation


protocol FetchProductsUseCaseProtocol {
    func execute(completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

class FetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        repository.fetchProducts(completion: completion)
    }
}
