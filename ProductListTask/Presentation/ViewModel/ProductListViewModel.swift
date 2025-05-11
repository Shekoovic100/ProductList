//
//  ProductListViewModel.swift
//  ProductListTask
//
//  Created by sherif on 10/05/2025.
//

import Foundation


class ProductListViewModel {
    
  //  private let networkService: NetworkServiceProtocol
    private let fetchProductsUseCase: FetchProductsUseCaseProtocol
    private var allProductsList: [Product] = []
    private var displayedProducts: [Product] = []
    private var currentPage = 0
    private let pageSize = 7
    private var hasMoreProducts = true
    
    
    
    var isLoading = false
    var isGridView = true
    
    var onProductsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    
    init(fetchProductsUseCase: FetchProductsUseCaseProtocol) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func fetchProductsList() {
        
        guard !isLoading, hasMoreProducts else {
            print("ViewModel: Fetch skipped - isLoading: \(isLoading), hasMoreProducts: \(hasMoreProducts)")
            return
        }
    
        isLoading = true
        onLoadingStateChanged?(true)
        
       
        if !allProductsList.isEmpty {
            loadNextPage()
            isLoading = false
            onLoadingStateChanged?(false)
            onProductsUpdated?()
            return
        }
        
        fetchProductsUseCase.execute  { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.isLoading = false
                self.onLoadingStateChanged?(false)
                
                switch result {
                case .success(let products):
                    self.allProductsList = products
                    self.loadNextPage()
                    self.onProductsUpdated?()
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
        
    }
    
    private func loadNextPage() {
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allProductsList.count)
        guard startIndex < allProductsList.count else { return }
        
        let newProducts = Array(allProductsList[startIndex..<endIndex])
        displayedProducts.append(contentsOf: newProducts)
        currentPage += 1
        hasMoreProducts = endIndex < allProductsList.count
    }
    
    
    func toggleViewMode() {
        isGridView.toggle()
        onProductsUpdated?()
    }
    
    
    var numberOfProducts: Int {
        return displayedProducts.count
    }
    
    func product(at index: Int) -> Product {
        return displayedProducts[index]
    }
    
    
    
}
