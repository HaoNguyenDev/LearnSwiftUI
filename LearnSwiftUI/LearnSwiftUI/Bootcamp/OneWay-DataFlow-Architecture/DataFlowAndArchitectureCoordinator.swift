//
//  DataFlowAndArchitectureCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/1/26.
//

import SwiftUI

extension Route {
    enum DataFlowAndArchitectureRouter: String, Routable {
        case exampleView
        var id: String { self.rawValue }
    }
}

struct DataFlowAndArchitectureCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.DataFlowAndArchitectureRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("ONE-WAY DATA FLOW & ARCHITECTURE")
    }
    
    @ViewBuilder
    private var contentView: some View {
        DataFlowAndArchitectureBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
    }
}

extension DataFlowAndArchitectureCoordinator {
    func viewForRoute(route: ScreenRoute) -> some View {
        switch route {
        case .exampleView: EmptyView()
        }
    }
}
