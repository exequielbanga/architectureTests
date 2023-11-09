//
//  
//  LoginViewController.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//
//
import UIKit

class LoginViewController: BaseViewController<LoginViewModel, LoginView>{
  
  var coordinator: AuthCoordinator!
  
  init(viewModel: LoginViewModel, coordinator: AuthCoordinator) {
    self.coordinator = coordinator
    super.init(viewModel: viewModel)
  }
  
  override init(viewModel: LoginViewModel) {
    fatalError("You should call init(viewModel, coordinator:) instead")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func bindViewModelEvents() {
    super.bindViewModelEvents()
    
    viewModel.onShowAlert
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] alertInfo in
        self?.onShowAlert(alertInfo)
      })
      .store(in: &cancellables)
    self.bind(event: viewModel.onContinueFlow, action:coordinator.continueFlow )
  }
  
  func onShowAlert(_ alertInfo: LoginViewModel.AlertInfo) {
    showAlert(title: alertInfo.title, message: alertInfo.message)
  }
  
  func showAlert(title: String? = nil, message: String?, style: UIAlertController.Style = .alert) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
    self.present(alert, animated: true)
  }
  
}
