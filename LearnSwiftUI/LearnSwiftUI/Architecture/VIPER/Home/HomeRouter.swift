//
//  HomeRouter.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//
import UIKit

class HomeRouter: HomeRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToLoginScreen() {
        // Perform screen switching, e.g. pop to login screen
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}

