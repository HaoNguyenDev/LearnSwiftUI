//
//  SafeAreaInsetsBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

extension Route {
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
    typealias ScreenRoute = Route.SafeAreaInsetsBootcampRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    private func getView() -> some View {
        SafeAreaInsetsBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
            .navigationTitle("SafeArea, Insets & Keyboard Layout Traps")
    }
}

extension SafeAreaInsetsBootcampCoordinator {
    func viewForRoute(route: Route.SafeAreaInsetsBootcampRouter) -> some View {
        switch route {
        case .exampleSubview:
            EmptyView()
        }
    }
}
