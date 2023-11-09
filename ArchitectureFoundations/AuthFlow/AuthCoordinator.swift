//
//  AuthCoordinator.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//

import UIKit

class AuthCoordinator: UINavigationController,Coordinator{
  init() {
    super.init(nibName: nil, bundle: nil)
    let loginData = LoginData()
    let viewModel = LoginViewModel(model: loginData)
    let viewController = LoginViewController(viewModel: viewModel, coordinator: self)
    viewControllers = [viewController]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func rootViewController() -> UIViewController{
    return self
  }
  
  func continueFlow(){
    guard let window = self.view.window else{ return }
    let mainCoordinator = MainCoordinator()
    
    window.rootViewController = mainCoordinator.rootViewController()
  }
}

