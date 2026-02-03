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
        case phaseAnimationExample
        case pulsingCircle
        case timelineAnimation
        
        var id: String { rawValue }
        
        var title: String {
            switch self {
            case .basicExample: "Basic example - Converting between two shapes"
            case .tabbar: "Tab Bar with dynamic indicators"
            case .cardExpansionExample: "Card Expansion"
            case .phaseAnimationExample: "Phase Animation Loading"
            case .pulsingCircle: "Pulsing Circle"
            case .timelineAnimation: "Timeline Animation"
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
        contentView
            .customNavigationTitle("Advanced Animation")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    @ViewBuilder
    private var contentView: some View {
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
        case .phaseAnimationExample:
            PhaseAnimationExample()
        case .pulsingCircle:
            PulsingCircle()
        case .timelineAnimation:
            TimelineAnimationExample()
        }
    }
}
