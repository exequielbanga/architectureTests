//
//  BaseViewModel.swift
//  UIandVMBinding
//
//  Created by Exequiel Banga on 6/12/23.
//

import Foundation

class BaseViewModel<CustomModel> {
    var model: CustomModel!

    init(model: CustomModel) {
        self.model = model
        self.setup()
    }

    /// Called after the model is setted. Here you can set up all the view model's properties, bind to properties and events, etc.
    func setup() {
    }
}
