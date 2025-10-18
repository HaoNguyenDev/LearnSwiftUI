//
//  HomeViewProtocol.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//


import Foundation
import UIKit

// Protocol for View (request Presenter to provide data/logic)
protocol HomeViewProtocol: AnyObject {
    func displayUser(name: String)
}

// Protocol for Presenter (receive events from View and Interactor)
protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func backToLogin()
    func userDidReceive(_ user: User)
}

// Protocol for Interactor (define business to get data)
protocol HomeInteractorProtocol: AnyObject {
    func fetchUserData()
}

// Protocol for Router (define navigation)
protocol HomeRouterProtocol: AnyObject {
    func navigateToLoginScreen()
}
