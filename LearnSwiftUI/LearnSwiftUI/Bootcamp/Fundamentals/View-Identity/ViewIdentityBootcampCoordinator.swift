//
//  ViewIdentityBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/1/26.
//

import SwiftUI

extension Route {
    enum ViewIdentityRouter: String, Routable {
        case exampleView
        var id: String { self.rawValue }
    }
}

struct ViewIdentityBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.ViewIdentityRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("VIEW IDENTITY & DIFFING SYSTEM")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    @ViewBuilder
    private var contentView: some View {
        ViewIdentityBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
    }
}

extension ViewIdentityBootcampCoordinator {
    func viewForRoute(route: Route.ViewIdentityRouter) -> some View {
        switch route {
        case .exampleView: EmptyView()
        }
    }
}
