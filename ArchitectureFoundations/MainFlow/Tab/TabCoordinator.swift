//
//  TabCoordinator.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//

import UIKit

class TabCoordinator: UINavigationController,Coordinator{
  init() {
    super.init(nibName: nil, bundle: nil)
    let tabData = Products()
    let viewModel = TabViewModel(model: tabData)
    let viewController = TabViewController(viewModel: viewModel, coordinator: self)
    viewControllers = [viewController]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func rootViewController() -> UIViewController{
    return self
  }
  
  func back(){
    print("continue")
    guard let window = self.view.window else{ return }
    
    window.rootViewController = AuthCoordinator().rootViewController()
    
  }
}
