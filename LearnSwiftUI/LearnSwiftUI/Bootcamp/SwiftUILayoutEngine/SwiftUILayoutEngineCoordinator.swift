//
//  SwiftUILayoutEngineCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/1/26.
//

import SwiftUI

extension Route {
    enum SwiftUILayoutEngineRouter: Routable {
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
    typealias ScreenRoute = Route.SwiftUILayoutEngineRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        SwiftUILayoutEngineBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
            .navigationTitle("SwiftUI Layout Engine")
    }
}

extension SwiftUILayoutEngineCoordinator {
    func viewForRoute(route: Route.SwiftUILayoutEngineRouter) -> some View {
        switch route {
        case .subviewExample:
            EmptyView()
        }
    }
}
