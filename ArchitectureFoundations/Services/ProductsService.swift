//
//  ProductsService.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//

import Foundation

class ProductService: AuthorizedService{
  static let shared = ProductService()
  
  func getProducts() async throws -> Products {
    let (data, response) = try await self.get(urlString: "products")
    return try JSONDecoder().decode(Products.self, from: try mapResponse(response: (data,response)))
  }
  
  func createProduct(productCreation: ProductCreation) async throws{
    let (data, response) = try await self.post(urlString: "products", body:productCreation)
    _ = try JSONDecoder().decode(ProductCreation.self, from: try mapResponse(response: (data,response)))
  }
  
  func changeProduct(product: ProductElement) async throws{
    _ = try await self.put(urlString: "https://httpbin.org/put", body:product, usingBaseURL: false)
  }
  
  func deleteProduct(product: ProductElement) async throws{
    _ = try await self.delete(urlString: "https://httpbin.org/delete")
  }
  
}
