//
//  StateManagementDeepDiveCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

extension Route {
    enum StateManagementDeepDiveRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        
        var id: String { rawValue }
    }
}
struct StateManagementDeepDiveCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.StateManagementDeepDiveRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("State Management Deep Dive", subtitle: "(@State, @Binding)")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    @ViewBuilder
    private var contentView: some View {
        StateManagementDeepDiveBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension StateManagementDeepDiveCoordinator {
    func viewForRoute(route: ScreenRoute) -> some View {
        EmptyView()
    }
}
