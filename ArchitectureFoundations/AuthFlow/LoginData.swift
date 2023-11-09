//
//  
//  Login.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//
//
import Foundation

import Foundation
struct LoginData: Codable {

    let username: String?
    let password: String?
  
  init(username: String? = nil, password: String? = nil) {
    self.username = username
    self.password = password
  }
}
