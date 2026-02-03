//
//  EquatableViewBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/1/26.
//

import SwiftUI

extension Route {
    enum EquatableViewRouter: String, CaseIterable, Routable {
        case equatableViewDemo
        var id: String { self.rawValue }
        var title: String {
            switch self {
            case .equatableViewDemo: "EquatableView Demo"
            }
        }
    }
}

struct EquatableViewBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.EquatableViewRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("EquatableView")
    }
    
    @ViewBuilder
    private var contentView: some View {
        EquatableViewBootcamp(gotoDemo: { demo in
            navRoute.push(demo, animate: true)
        })
        .navigationDestination(for: ScreenRoute.self, destination: { router in
            viewForRoute(route: router)
        })
    }
}

extension EquatableViewBootcampCoordinator {
    func viewForRoute(route: ScreenRoute) -> some View {
        switch route {
        case .equatableViewDemo: EquatableViewDemo()
        }
    }
}

struct TestEquatableBootcamp: View {
    @State private var root: NavRoute
    
    init() {
        self.root = NavRoute()
    }
    
    var body: some View {
        NavigationStack(path: $root.path) {
            EquatableViewBootcampCoordinator(navRouter: root)
        }
    }
}

#Preview {
    TestEquatableBootcamp()
}
