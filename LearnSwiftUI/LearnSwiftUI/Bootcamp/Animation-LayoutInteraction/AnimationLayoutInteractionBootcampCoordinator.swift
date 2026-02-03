//
//  AnimationLayoutInteractionBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

extension Route {
    enum AnimationLayoutInteractionRouter: String, Routable {
        case exampleSubview
        
        var id: String { self.rawValue }
    }
}

struct AnimationLayoutInteractionBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.AnimationLayoutInteractionRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("ANIMATION & LAYOUT INTERACTION")
    }
    
    @ViewBuilder
    private var contentView: some View {
        AnimationLayoutInteractionBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
    }
}

extension AnimationLayoutInteractionBootcampCoordinator {
    func viewForRoute(route: Route.AnimationLayoutInteractionRouter) -> some View {
        switch route {
        case .exampleSubview:
            EmptyView()
        }
    }
}
