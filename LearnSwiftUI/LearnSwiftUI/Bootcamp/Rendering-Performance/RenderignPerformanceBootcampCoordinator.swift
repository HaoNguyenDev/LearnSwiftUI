//
//  RenderignPerformanceBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 23/1/26.
//

import SwiftUI

extension Router {
    enum RenderignPerformanceRouter: String, Routable {
        case exampleView
        var id: String { self.rawValue }
    }
}

struct RenderignPerformanceBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.RenderignPerformanceRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        RenderingPerformanceBootcamp()
            .navigationDestination(for: ScreenRouter.self, destination: { router in
                    viewForRouter(router: router)
            })
            .navigationTitle("Rendering & Performance")
    }
}

extension RenderignPerformanceBootcampCoordinator {
    func viewForRouter(router: Router.RenderignPerformanceRouter) -> some View {
        switch router {
        case .exampleView: EmptyView()
        }
    }
}
