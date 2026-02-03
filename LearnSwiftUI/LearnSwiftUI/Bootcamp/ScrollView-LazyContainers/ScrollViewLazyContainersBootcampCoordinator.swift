//
//  ScrollViewLazyContainersBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/1/26.
//

import SwiftUI

extension Route {
    enum ScrollViewLazyContainersRouter: Routable {
        case exampleSubview
        
        var id: String {
            switch self {
            case .exampleSubview:
                return "exampleSubview"
            }
        }
    }
}

struct ScrollViewLazyContainersBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.ScrollViewLazyContainersRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("ScrollView & Lazy Containers")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    @ViewBuilder
    private var contentView: some View {
        ScrollViewLazyContainersBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
    }
}

extension ScrollViewLazyContainersBootcampCoordinator {
    func viewForRoute(route: Route.ScrollViewLazyContainersRouter) -> some View {
        switch route {
        case .exampleSubview:
            EmptyView()
        }
    }
}
