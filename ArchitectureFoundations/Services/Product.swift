//
//  Product.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//

import Foundation

typealias Products = [ProductElement]

struct ProductElement: Codable, Hashable {
    
    static func == (lhs: ProductElement, rhs: ProductElement) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let images: [String]
    let creationAt, updatedAt: String?
    let category: Category
}

struct Category: Codable {
    let id: Int?
    let name: String
    let image: String?
    let creationAt, updatedAt: String?
}


struct ProductCreation: Codable {
   
    let title: String
    let price: Int
    let description: String
    let categoryID: Int?
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case title, price, description
        case categoryID = "categoryId"
        case images
    }
    
}
