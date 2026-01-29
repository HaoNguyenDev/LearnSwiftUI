//
//  StackViewBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/1/26.
//

import SwiftUI

extension Route {
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
    typealias ScreenRoute = Route.StackViewRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        StackViewBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
            .navigationTitle("VStack / HStack / ZStack")
    }
    
}

extension StackViewBootcampCoordinator {
    func viewForRoute(route: Route.StackViewRouter) -> some View {
        switch route {
        case .subviewExample:
            EmptyView()
        }
    }
}


