//
//  
//  LoginViewModel.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//
//
import Foundation
import Combine

class LoginViewModel: BaseViewModel<LoginData>{
  //MARK: Events
  
  /////Description of the event
  var onContinueFlow = PassthroughSubject<Void, Never>()

  struct AlertInfo{
    let title: String
    let message: String?
  }
  let alertInfo = AlertInfo(title: "Can't Login", message: "Username or password are incorrect")
  var onShowAlert = PassthroughSubject<AlertInfo, Never>()

  //MARK: Properties
  
  private let service: any AuthService
  
  ///User name
  @Published var username: String!{
    didSet{
      self.updateLoginButtonEnabled()
    }
  }
  let userNamePlaceholder = "User name"
  
  ///Password
  @Published var password: String!{
    didSet{
      self.updateLoginButtonEnabled()
    }
  }
  let passwordPlaceholder = "Password"
  
  ///Tells if the login button is enabled or not
  @Published var loginButtonEnabled: Bool!
    
  init(model: LoginData, service:any AuthService = AuthServiceProduction()) {
    self.service = service
    super.init(model: model)
    
  }
  override func setup(){
    super.setup()
    username = model.username ?? ""
    password = model.password ?? ""
  }
  
  private func updateLoginButtonEnabled(){
    loginButtonEnabled = username.count > 0 && password.count > 0
  }
  
  func loginButtonTapped(){
    Task{
      do{
        self.model = LoginData(username: username, password: password)
        try await service.login(loginData: model)
        onContinueFlow.send()
      }catch AuthError.invalidUserNameOrPassword{
        onShowAlert.send(alertInfo)
      }
    }
  }
}
