//
//  SwiftUILayoutEngineCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/1/26.
//

import SwiftUI

extension Router {
    enum SwiftUILayoutEngineRouter: Routable {
        case subviewExample
        
        var id: String {
            switch self {
            case .subviewExample:
                return "SwiftUILayoutEngine.subviewExample"
            }
        }
    }
}

struct SwiftUILayoutEngineCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.SwiftUILayoutEngineRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        SwiftUILayoutEngineBootcamp()
            .navigationTitle("SwiftUI Layout Engine")
    }
}

extension SwiftUILayoutEngineCoordinator {
    func viewForRouter(router: Router.SwiftUILayoutEngineRouter) -> some View {
        switch router {
        case .subviewExample:
            EmptyView()
        }
    }
}
