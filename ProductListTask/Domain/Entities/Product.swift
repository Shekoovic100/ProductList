//
//  Product.swift
//  ProductListTask
//
//  Created by sherif on 10/05/2025.
//

import Foundation

struct Product: Codable,Equatable {

    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating

}
