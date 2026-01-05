//
//  SwiftUILayoutSystemCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/1/26.
//

import SwiftUI

extension Router {
    enum SwiftUILayoutSystem: Routable {
        case subviewExample
        
        var id: String {
            switch self {
            case .subviewExample:
                return "SwiftUILayoutSystem.subviewExample"
            }
        }
    }
}

struct SwiftUILayoutSystemCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.SwiftUILayoutSystem
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        SwiftUILayoutSystemBootcamp()
            .navigationTitle("SwiftUI Layout System")
    }
}

extension SwiftUILayoutSystemCoordinator {
    func viewForRouter(router: Router.SwiftUILayoutSystem) -> some View {
        switch router {
        case .subviewExample:
            EmptyView()
        }
    }
}
