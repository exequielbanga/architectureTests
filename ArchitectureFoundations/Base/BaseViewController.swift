//
//  BaseViewController.swift
//  UIandVMBinding
//
//  Created by Exequiel Banga on 6/12/23.
//

import UIKit
import Combine

class BaseViewController<CustomViewModel, CustomView: BaseView<CustomViewModel>>: UIViewController {

    /// Set of cancellable observers
    var cancellables = Set<AnyCancellable>()
    
    /// The main view of the controller
    var rootView: CustomView { view as! CustomView }

    init(viewModel: CustomViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.rootView.configure(viewModel)
        bindViewModelEvents()
    }

    /// The view model of the main view
    var viewModel: CustomViewModel {
        return rootView.viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() { view = CustomView() }

    /// Called just after the view model is set.
    /// Use this method to bind your view controller with the view model's properties or events to handle flow changes
    func bindViewModelEvents() {
        // self.bind(event: viewModel.<#event#>, action: <#action#>)
    }

    /// Binds one event with a function, both with no arguments or parameters
    /// - Parameters:
    ///     - event: The event to bind with.
    ///     - action: The function to be called when the event happens.
    /// - Returns: Void
    func bind(event: PassthroughSubject<Void, Never>, action: @escaping () -> Void) {
        event
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                action()
            })
            .store(in: &cancellables)
    }
}
