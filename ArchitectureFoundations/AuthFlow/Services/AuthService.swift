//
//  AuthService.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 19/10/2023.
//

import Foundation

protocol AuthService{
    func login(loginData:LoginData) async throws
}

enum AuthError: Error{
    case invalidUserNameOrPassword
}

class AuthServiceProduction: Service, AuthService{
    func login(loginData:LoginData) async throws {
        if loginData.username != "Exe" || loginData.password != "password"{
            throw AuthError.invalidUserNameOrPassword
        }
    }
}
