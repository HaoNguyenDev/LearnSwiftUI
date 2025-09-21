//
//  ViperProtocol.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//

import Foundation

/*
 Defining Protocols
 Using protocols allows components to communicate with each other without needing to know the details about each other.
 This increases flexibility and ease of testing.
 */

// Protocol for View (request Presenter to provide data/logic)
protocol LoginViewProtocol: AnyObject {
    func displayError(_ message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

// Protocol for Presenter (receive events from View)
protocol LoginPresenterProtocol: AnyObject {
    func loginButtonTapped(username: String, password: String)
}

// Protocol for Interactor (business definition)
protocol LoginInteractorProtocol: AnyObject {
    func performLogin(with credentials: LoginCredentials)
}

// Protocol for Router (navigation definition)
protocol LoginRouterProtocol: AnyObject {
    func navigateToHomeScreen()
}
