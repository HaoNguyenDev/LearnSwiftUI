//
//  AlignmentBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

extension Route {
    enum AlignmentRouter: Routable {
        case subviewExample
        
        var id: String {
            switch self {
            case .subviewExample:
                return "AlignmentRouter.subviewExample"
            }
        }
    }
}

struct AlignmentBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.AlignmentRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        AlignmentBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
            .navigationTitle("Alignment-AlignmentGuide")
    }
}

extension AlignmentBootcampCoordinator {
    func viewForRoute(route: Route.AlignmentRouter) -> some View {
        switch route {
        case .subviewExample:
            EmptyView()
        }
    }
}
