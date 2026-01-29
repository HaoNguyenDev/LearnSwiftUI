//
//  NavigationBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/1/26.
//

import SwiftUI

extension Route {
    enum NavigationRouter: String, CaseIterable, Routable {
        case demo1
        
        var id: String { self.rawValue }
        var title: String {
            switch self {
            case .demo1: "Demo 1"
            }
        }
    }
}
struct NavigationBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.NavigationRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        NavigationBootcamp(gotoDemo: { demo in
            switch demo {
            case .demo1:
                navRoute.push(ScreenRoute.demo1, animate: true)
            }
        })
        .navigationDestination(for: ScreenRoute.self) { router in
            viewForRoute(route: router)
        }
        .navigationTitle("Navigation Bootcamp")
    }
    
}

extension NavigationBootcampCoordinator {
    func viewForRoute(route: ScreenRoute) -> some View {
        switch route {
        case .demo1: Text("Demo 1")
        }
    }
}

struct NaviationBootcampRootView: View {
    @State private var nav: NavRoute
    
    init() {
        self.nav = NavRoute()
    }
    var body: some View {
        NavigationStack(path: $nav.path) {
            NavigationBootcampCoordinator(navRouter: nav)
        }
    }
}

#Preview(body: {
    NaviationBootcampRootView()
})
