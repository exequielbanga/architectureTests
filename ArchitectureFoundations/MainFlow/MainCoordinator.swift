//
//  MainCoordinator.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//

import UIKit

class MainCoordinator: UITabBarController,Coordinator{
  
  init() {
    super.init(nibName: nil, bundle: nil)
    
    let firstCoordinator = TabCoordinator()
    firstCoordinator.rootViewController().tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)

    let secondCoordinator = TabCoordinator()
    secondCoordinator.rootViewController().tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 2)
    
    viewControllers = [firstCoordinator.rootViewController(),secondCoordinator.rootViewController()]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func rootViewController() -> UIViewController {
    self
  }
}
