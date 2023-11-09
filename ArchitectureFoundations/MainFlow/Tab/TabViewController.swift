//
//  
//  TabViewController.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//
//
import UIKit

class TabViewController: BaseViewController<TabViewModel, TabView>{
  var coordinator: TabCoordinator!
  
  init(viewModel: TabViewModel, coordinator: TabCoordinator) {
    self.coordinator = coordinator
    super.init(viewModel: viewModel)
  }
  
  override init(viewModel: TabViewModel) {
    fatalError("You should call init(viewModel, coordinator:) instead")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
