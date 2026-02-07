//
//  ViewCompositionAndViewBuilderCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/2/26.
//

import SwiftUI

extension Route {
    enum ViewCompositionAndViewBuilder: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        
        var id: String { rawValue }
    }
}

struct ViewCompositionAndViewBuilderCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.ViewCompositionAndViewBuilder
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        content
            .customNavigationTitle("View Composition - ViewBuilder")
    }
    
    private var content: some View {
        ViewCompositionAndViewBuilderBootcamp(gotoDemo: { route in
            navRoute.push(route, animate: true)
        })
        .navigationDestination(for: ScreenRoute.self) { route in
            viewForRoute(route: route)
        }
    }
}

extension ViewCompositionAndViewBuilderCoordinator {
    func viewForRoute(route: Route.ViewCompositionAndViewBuilder) -> some View {
        EmptyView()
    }
}
