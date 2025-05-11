//
//  FetchProductsUseCaseTests.swift
//  ProductListTaskTests
//
//  Created by sherif on 11/05/2025.
//

import XCTest
@testable import ProductListTask
final class FetchProductsUseCaseTests: XCTestCase {

    var sut: FetchProductsUseCase!
    var mockRepository: MockProductRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockProductRepository()
        sut = FetchProductsUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
        

    func testExecute_success_returnsProducts() {
        // Given
        let products = [Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 10.0, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", category: "men's clothing", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 3.9, count: 120))]
        mockRepository.productsToReturn = products
        let expectation = XCTestExpectation(description: "Fetch products succeeds")
        
        // When
        sut.execute { result in
            // Then
            switch result {
            case .success(let received):
                XCTAssertEqual(received, products)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func testExecute_emptyProducts_returnsEmpty() {
         // Given
         mockRepository.productsToReturn = []
         let expectation = XCTestExpectation(description: "Fetch empty products")
         
         // When
         sut.execute { result in
             // Then
             switch result {
             case .success(let received):
                 XCTAssertTrue(received.isEmpty)
                 expectation.fulfill()
             case .failure:
                 XCTFail("Expected success with empty array")
             }
         }
         
         wait(for: [expectation], timeout: 1.0)
     }

}
