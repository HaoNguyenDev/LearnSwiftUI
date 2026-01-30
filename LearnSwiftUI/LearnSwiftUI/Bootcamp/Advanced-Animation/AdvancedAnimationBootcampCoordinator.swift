//
//  AdvancedAnimationBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/1/26.
//

import SwiftUI

extension Route {
    enum AdvancedAnimationBootcampRoute: String, CaseIterable, Routable {
        case basicExample
        case tabbar
        case cardExpansionExample
        
        var id: String { rawValue }
        
        var title: String {
            switch self {
            case .basicExample: "Basic example - Converting between two shapes"
            case .tabbar: "Tab Bar with dynamic indicators"
            case .cardExpansionExample: "Card Expansion"
            }
        }
    }
}

struct AdvancedAnimationBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.AdvancedAnimationBootcampRoute
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
            .navigationTitle("Advanced Animation")
    }
    
    @ViewBuilder
    private func getView() -> some View {
        AdvancedAnimationBootcamp(gotoDemo: { demo in
            navRoute.push(demo, animate: true)
        })
        .navigationDestination(for: ScreenRoute.self) { route in
            viewForRoute(route: route)
        }
    }
}

extension AdvancedAnimationBootcampCoordinator {
    @ViewBuilder
    func viewForRoute(route: Route.AdvancedAnimationBootcampRoute) -> some View {
        switch route {
        case .basicExample:
            BasicMatchedGeometryExample()
        case .tabbar:
            CustomTabBarExample()
        case .cardExpansionExample:
            CardExpansionExample()
        }
    }
}
