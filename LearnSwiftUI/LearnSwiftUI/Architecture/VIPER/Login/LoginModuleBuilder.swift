//
//  LoginModuleBuilder.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//


import UIKit

// USAGE: let vc = LoginModuleBuilder.createModule()

final class LoginModuleBuilder {
    
    static func createModule() -> UIViewController {
        
        // 1. Initialize all components
        let view = LoginViewController()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()

        // 2. Set up the connections (Wiring)

        // View -> Presenter
        view.presenter = presenter

        // Presenter -> View, Interactor, Router
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        // Interactor -> Presenter
        interactor.presenter = presenter

        // Router -> View (to navigate from)
        router.viewController = view

        // 3. Return the View Controller as the entry point of the module
        return view
    }
}
