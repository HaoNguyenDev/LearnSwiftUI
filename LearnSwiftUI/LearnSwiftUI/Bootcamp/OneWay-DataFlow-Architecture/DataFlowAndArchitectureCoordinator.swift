//
//  DataFlowAndArchitectureCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/1/26.
//

import SwiftUI

extension Router {
    enum DataFlowAndArchitectureRouter: String, Routable {
        case exampleView
        var id: String { self.rawValue }
    }
}

struct DataFlowAndArchitectureCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.DataFlowAndArchitectureRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        DataFlowAndArchitectureBootcamp()
            .navigationDestination(for: ScreenRouter.self, destination: { router in
                    viewForRouter(router: router)
            })
            .navigationTitle("ONE-WAY DATA FLOW & ARCHITECTURE")
    }
}

extension DataFlowAndArchitectureCoordinator {
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .exampleView: EmptyView()
        }
    }
}
