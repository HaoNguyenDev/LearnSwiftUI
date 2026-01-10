//
//  SafeAreaInsetsBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

extension Router {
    enum SafeAreaInsetsBootcampRouter: Routable {
        case exampleSubview
        
        var id: String {
            switch self {
            case .exampleSubview: return "SafeAreaInsetsBootcampRouter.exampleSubview"
            }
        }
    }
}

struct SafeAreaInsetsBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.SafeAreaInsetsBootcampRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    private func getView() -> some View {
        SafeAreaInsetsBootcamp()
            .navigationTitle("SafeArea, Insets & Keyboard Layout Traps")
    }
}

extension SafeAreaInsetsBootcampCoordinator {
    func viewForRouter(router: Router.SafeAreaInsetsBootcampRouter) -> some View {
        switch router {
        case .exampleSubview:
            EmptyView()
        }
    }
}
