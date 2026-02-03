//
//  SwiftUILayoutEngineCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/1/26.
//

import SwiftUI

extension Route {
    enum SwiftUILayoutEngineRoute: Routable {
        case subviewExample
        
        var id: String {
            switch self {
            case .subviewExample:
                return "SwiftUILayoutEngine.subviewExample"
            }
        }
    }
}

struct SwiftUILayoutEngineCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.SwiftUILayoutEngineRoute
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("SwiftUI Layout Engine")
    }
    
    @ViewBuilder
    private var contentView: some View {
        SwiftUILayoutEngineBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
    }
}

extension SwiftUILayoutEngineCoordinator {
    func viewForRoute(route: Route.SwiftUILayoutEngineRoute) -> some View {
        switch route {
        case .subviewExample:
            EmptyView()
        }
    }
}
