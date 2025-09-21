//
//  HomeModuleBuilder.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//

import UIKit

final class HomeModuleBuilder {
    
    static func createModule() -> UIViewController {
        
        // 1. Initialize all components
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        // 2. Set up connections
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        // 3. Return the fully configured View
        return view
    }
}
