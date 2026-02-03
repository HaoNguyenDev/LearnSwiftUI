//
//  SwiftUIArchitectureAndViewLifeCycleCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

extension Route {
    enum SwiftUIArchitectureAndViewLifeCycleRoute: String, CaseIterable, Routable {
        case demo1
        
        var id: String { rawValue }
        var title: String {
            switch self {
            case .demo1: "Demo 1"
            }
        }
    }
}
struct SwiftUIArchitectureAndViewLifeCycleCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.SwiftUIArchitectureAndViewLifeCycleRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("SwiftUI Architecture - View LifeCycle")
    }
    
    @ViewBuilder
    private var contentView: some View {
        SwiftUIArchitectureAndViewLifeCycleBootcamp(gotoDemo: { demo in
            navRoute.push(demo, animate: true)
        })
        .navigationDestination(for: ScreenRoute.self, destination: { route in
            viewForRoute(route: route)
        })
    }
}

extension SwiftUIArchitectureAndViewLifeCycleCoordinator {
    @ViewBuilder
    func viewForRoute(route: ScreenRoute) -> some View {
        switch route {
        case .demo1:
            EmptyView()
        }
    }
}
