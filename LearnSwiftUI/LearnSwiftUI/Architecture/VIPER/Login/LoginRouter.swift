//
//  LoginRouter.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?

    func navigateToHomeScreen() {
//        // Create Home screen
        let homeVC = HomeModuleBuilder.createModule()

        // Perform screen switching
        if let navigationController = viewController?.navigationController {
            navigationController.pushViewController(homeVC, animated: true)
        }
    }
}
