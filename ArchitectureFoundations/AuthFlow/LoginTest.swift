//
//  LoginTest.swift
//  ArchitectureFoundationsTests
//
//  Created by Exequiel Banga on 19/10/2023.
//

import XCTest
import Combine

@testable import ArchitectureFoundations

final class LoginTest: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginButtonEnabling(){
        let loginModel = LoginData()
        let loginViewModel = LoginViewModel(model: loginModel)
        
        XCTAssertFalse(loginViewModel.loginButtonEnabled)
        
        loginViewModel.username = "test"
        XCTAssertFalse(loginViewModel.loginButtonEnabled)

        loginViewModel.password = "test"
        XCTAssertTrue(loginViewModel.loginButtonEnabled)
    }
    
    func testLoginCorrectly(){
        let loginModel = LoginData()
        let loginViewModel = LoginViewModel(model: loginModel, service: AuthServiceMock())

        loginViewModel.username = "Test"
        loginViewModel.password = "password"

        let continueFlowExpectation = self.expectation(description: "Wait on continueFlow")
        let showAlertExpectation = self.expectation(description: "Wait on continueFlow")
        showAlertExpectation.isInverted = true

        loginViewModel.onContinueFlow.sink(){
            continueFlowExpectation.fulfill()
        }.store(in: &cancellables)

        loginViewModel.onShowAlert.sink(){ message in
            showAlertExpectation.fulfill()
        }.store(in: &cancellables)

        loginViewModel.loginButtonTapped()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoginIncorrectly(){
        let loginModel = LoginData()
        let loginViewModel = LoginViewModel(model: loginModel, service: AuthServiceMock())

        loginViewModel.username = "something"
        loginViewModel.password = "something"

        let continueFlowExpectation = self.expectation(description: "Wait on continueFlow")
        continueFlowExpectation.isInverted = true
        let showAlertExpectation = self.expectation(description: "Wait on continueFlow")
        
        loginViewModel.onContinueFlow.sink(){
            continueFlowExpectation.fulfill()
        }.store(in: &cancellables)

        loginViewModel.onShowAlert.sink(){ message in
            showAlertExpectation.fulfill()
        }.store(in: &cancellables)
        
        loginViewModel.loginButtonTapped()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
        }
    }

}
