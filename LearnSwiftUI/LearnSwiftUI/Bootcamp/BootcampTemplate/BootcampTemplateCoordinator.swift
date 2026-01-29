//
//  BootcampTemplateCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/1/26.
//

import SwiftUI

extension Route {
    enum BootcampTemplateRouter: String, CaseIterable, Routable {
        case childView1
        case childView2
        var id: String { self.rawValue }
        var title: String {
            switch self {
            case .childView1: "Child View 1"
            case .childView2: "Child View 2"
            }
        }
    }
}
struct BootcampTemplateCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.BootcampTemplateRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        BootcampTemplateView() { child in
            switch child {
            case .childView1:
                navRoute.push(ScreenRoute.childView1, animate: true)
            case .childView2:
                navRoute.push(ScreenRoute.childView2, animate: true)
            }
        }
        .navigationDestination(for: ScreenRoute.self, destination: { router in
            viewForRoute(route: router)
        })
        .navigationTitle("Bootcamp Template")
    }
}

extension BootcampTemplateCoordinator {
    func viewForRoute(route: ScreenRoute) -> some View {
        switch route {
        case .childView1: Text(route.title)
        case .childView2: Text(route.title)
        }
    }
}

struct RootDemo: View {
    @State private var nav = NavRoute()
    
    var body: some View {
        NavigationStack(path: $nav.path) {
            BootcampTemplateCoordinator(navRouter: nav)
        }
    }
}
#Preview {
    RootDemo()
}
