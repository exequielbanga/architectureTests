//
//  
//  LoginView.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//
//
import UIKit
import Combine

class LoginView:BaseView<LoginViewModel> {
  let margin = 20.0
  //View components
  var usernameTextField = UITextField()
  var passwordTextField = UITextField()
  var loginButton: UIButton!
  
  override func setup(){
    super.setup()
    backgroundColor = .white
    setupUsernameTextField()
    setupPasswordTextField()
    setupLoginButton()
  }
  
  fileprivate func setupUsernameTextField() {
    usernameTextField.delegate = self
    usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    addSubview(usernameTextField)
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: margin),
      usernameTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: margin),
      usernameTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: margin),
    ])
  }
  
  fileprivate func setupPasswordTextField() {
    passwordTextField.delegate = self
    passwordTextField.isSecureTextEntry = true
    passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
    addSubview(passwordTextField)
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      passwordTextField.topAnchor.constraint(equalTo: usernameTextField.layoutMarginsGuide.bottomAnchor, constant: margin),
      passwordTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: margin),
      passwordTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: margin),
    ])
  }
  
  fileprivate func setupLoginButton() {
    loginButton = UIButton(type: .system, primaryAction: UIAction(title: "Login", handler: {_ in self.onLoginButtonTapped()}))
    addSubview(loginButton)
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: margin),
      loginButton.widthAnchor.constraint(equalToConstant: 200),
      loginButton.heightAnchor.constraint(equalToConstant: 44),
      loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
  
  //Bind view model properties with view's components
  override func bindViewModel(){
    usernameTextField.placeholder = viewModel.userNamePlaceholder
    viewModel?.$username
        .receive(on: DispatchQueue.main)
        .assign(to: \.text, on: usernameTextField).store(in: &cancellables)

    passwordTextField.placeholder = viewModel.passwordPlaceholder
    viewModel?.$password
        .receive(on: DispatchQueue.main)
        .assign(to: \.text, on: passwordTextField).store(in: &cancellables)

    viewModel?.$loginButtonEnabled
      .receive(on: DispatchQueue.main)
      .sink(){[weak self] newValue in
        self?.loginButton.isEnabled = newValue ?? false
      }.store(in: &cancellables)

  }
  
  func onLoginButtonTapped(){
    viewModel.loginButtonTapped()
  }
}

extension LoginView: UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameTextField{
      passwordTextField.becomeFirstResponder()
    }else{
      textField.resignFirstResponder()
      onLoginButtonTapped()
    }
    return true
  }
  
  @objc func textFieldDidChange(_ textField: UITextField){
    if textField == usernameTextField{
      viewModel.username = textField.text
    }else{
      viewModel.password = textField.text
    }
  }

}
