//
//  AlignmentBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

extension Router {
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
    typealias ScreenRouter = Router.AlignmentRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        AlignmentBootcamp()
            .navigationDestination(for: ScreenRouter.self, destination: { router in
                    viewForRouter(router: router)
            })
            .navigationTitle("Alignment-AlignmentGuide")
    }
}

extension AlignmentBootcampCoordinator {
    func viewForRouter(router: Router.AlignmentRouter) -> some View {
        switch router {
        case .subviewExample:
            EmptyView()
        }
    }
}
