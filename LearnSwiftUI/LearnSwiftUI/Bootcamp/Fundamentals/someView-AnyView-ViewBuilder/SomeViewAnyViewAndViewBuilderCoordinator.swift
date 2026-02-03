//
//  SomeViewAnyViewAndViewBuilderCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

extension Route {
    enum SomeViewAnyViewAndViewBuilderRoute: String, CaseIterable, Routable {
        case demo1
        
        var id: String { rawValue }
        var title: String {
            switch self {
            case .demo1: "Demo 1"
            }
        }
    }
}

struct SomeViewAnyViewAndViewBuilderCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.SomeViewAnyViewAndViewBuilderRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }

    var body: some View {
        contentView
            .customNavigationTitle("some View - AnyView - @ViewBuilder")
    }
    
    @ViewBuilder
    private var contentView: some View {
        SomeViewAnyViewAndViewBuilderBootcamp(gotoDemo: {demo in
            navRoute.push(demo, animate: true)
        })
        .navigationDestination(for: ScreenRoute.self) { route in
            viewForRoute(route: route)
        }
    }
}

extension SomeViewAnyViewAndViewBuilderCoordinator {
    func viewForRoute(route: Route.SomeViewAnyViewAndViewBuilderRoute) -> some View {
        EmptyView()
    }
}
