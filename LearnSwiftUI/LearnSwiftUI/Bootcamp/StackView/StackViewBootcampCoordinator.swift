//
//  StackViewBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/1/26.
//

import SwiftUI

extension Router {
    enum StackViewRouter: Routable {
        case subviewExample
        
        var id: String {
            switch self {
            case .subviewExample:
                return "StackView.subviewExample"
            }
        }
    }
}

struct StackViewBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.StackViewRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        StackViewBootcamp()
            .navigationTitle("Stack View")
    }
    
}

extension StackViewBootcampCoordinator {
    func viewForRouter(router: Router.StackViewRouter) -> some View {
        switch router {
        case .subviewExample:
            EmptyView()
        }
    }
}


