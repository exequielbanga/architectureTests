//
//  
//  TabViewModel.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//
//
import Foundation
import Combine

class TabViewModel: BaseViewModel<Products>{
//MARK: Properties
@Published var products: Products!

  override func setup(){
    super.setup()
    products = model ?? []
    Task{
      do{
        self.products = try await ProductService.shared.getProducts()
      }catch NetworkError.unauthorized{
        print("You must login")
      }catch{
        print("Error: \(error)")
      }
    }
  }
    
}
