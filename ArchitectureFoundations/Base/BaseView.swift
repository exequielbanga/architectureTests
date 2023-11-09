//
//  BaseView.swift
//  UIandVMBinding
//
//  Created by Exequiel Banga on 6/12/23.
//

import UIKit
import Combine

class BaseView<ViewModel: Any>: UIView {
        
    /// Set of cancellable observers
    var cancellables = Set<AnyCancellable>()
    
    /// The view model of the view
    var viewModel: ViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ vm:ViewModel){
        self.viewModel = vm
        self.bindViewModel()
    }
    
    /// Called just after the view is created and before the view model is set.
    /// Use this method to create and arrange subviews
    func setup(){
        
    }

    /// Called just after the view model is set.
    /// Use this method to bind your subviews with the view model's properties or events
    func bindViewModel(){
    }
}
