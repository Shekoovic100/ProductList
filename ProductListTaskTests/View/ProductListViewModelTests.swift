//
//  ProductListViewModelTests.swift
//  ProductListTaskTests
//
//  Created by sherif on 12/05/2025.
//

import XCTest
@testable import ProductListTask

final class ProductListViewModelTests: XCTestCase {
    
    var sut: ProductListViewModel!
    var mockUseCase: MockFetchProductsUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchProductsUseCase()
        sut = ProductListViewModel(fetchProductsUseCase: mockUseCase)
    }
    
    override func tearDown() {
        
        mockUseCase = nil
        sut = nil
        super.tearDown()
    }
    
    
    func testFetchProductsList_success_loadsFirstItems() {
        
        // Given
        let products = (1...10).map { Product(id: $0, title: "Product \($0)", price: Double($0), description: "Desc", category: "Category", image: "", rating: Rating(rate: 5.5, count: 122)) }
        mockUseCase.productsToReturn = products
        let expectation = XCTestExpectation(description: "Products updated")
        var capturedProductsCount = 0
        
        // When
        sut.onProductsUpdated = {
            capturedProductsCount = self.sut.numberOfProducts
            expectation.fulfill()
        }
        sut.onLoadingStateChanged = { isLoading in
            if !isLoading { XCTAssertEqual(self.sut.isLoading, false) }
        }
        sut.fetchProductsList()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(capturedProductsCount, 7)
        XCTAssertEqual(sut.product(at: 0), products[0])
        XCTAssertTrue(sut.hasMoreProducts)
        XCTAssertEqual(sut.numberOfProducts, 7)
    }
    
}
