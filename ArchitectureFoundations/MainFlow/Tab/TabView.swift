//
//  
//  TabView.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//
//
import UIKit
import Combine

class TabView:BaseView<TabViewModel> {
  let margin = 20.0
  let cellIdentifier = "TabViewCell"
  //MARK: subviews
    var table = UITableView()
  
  override func setup(){
    super.setup()

    backgroundColor = .init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    
    table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    table.delegate = self
    table.dataSource = self
    addSubview(table)
    table.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      table.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
      table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin),
      table.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
      table.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -margin),
    ])

  }
  
  override func bindViewModel(){
    //Manual binding
        viewModel?.$products
          .receive(on: DispatchQueue.main)
          .sink(){[weak self] newValue in
            self?.table.reloadData()
          }.store(in: &cancellables)
  }
  
}

extension TabView: UITableViewDelegate{
  
}

extension TabView: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    let product = viewModel.products[indexPath.row]

    var contentConfiguration = cell.defaultContentConfiguration()

    contentConfiguration.text = product.title ?? "No name"
    
    cell.contentConfiguration = contentConfiguration

    return cell
  }
  
  
}
