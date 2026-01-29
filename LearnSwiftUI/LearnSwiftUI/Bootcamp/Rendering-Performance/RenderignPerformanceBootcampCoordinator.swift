//
//  RenderignPerformanceBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 23/1/26.
//

import SwiftUI

extension Route {
    enum RenderignPerformanceRouter: String, Routable {
        case exampleView
        var id: String { self.rawValue }
    }
}

struct RenderignPerformanceBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.RenderignPerformanceRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        RenderingPerformanceBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
            .navigationTitle("Rendering & Performance")
    }
}

extension RenderignPerformanceBootcampCoordinator {
    func viewForRoute(route: Route.RenderignPerformanceRouter) -> some View {
        switch route {
        case .exampleView: EmptyView()
        }
    }
}
