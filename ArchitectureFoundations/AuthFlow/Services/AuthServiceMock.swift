//
//  AuthServiceMock.swift
//  ArchitectureFoundationsTests
//
//  Created by Exequiel Banga on 19/10/2023.
//

import Foundation
@testable import ArchitectureFoundations

class AuthServiceMock:AuthService{
    func login(loginData:LoginData) async throws {
        if loginData.username != "Test" || loginData.password != "password"{
            throw AuthError.invalidUserNameOrPassword
        }
    }
}
