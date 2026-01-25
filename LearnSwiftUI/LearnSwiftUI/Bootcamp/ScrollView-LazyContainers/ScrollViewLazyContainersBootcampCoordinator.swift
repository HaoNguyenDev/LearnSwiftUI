//
//  ScrollViewLazyContainersBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/1/26.
//

import SwiftUI

extension Router {
    enum ScrollViewLazyContainersRouter: Routable {
        case exampleSubview
        
        var id: String {
            switch self {
            case .exampleSubview:
                return "exampleSubview"
            }
        }
    }
}

struct ScrollViewLazyContainersBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.ScrollViewLazyContainersRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        ScrollViewLazyContainersBootcamp()
            .navigationDestination(for: ScreenRouter.self, destination: { router in
                    viewForRouter(router: router)
            })
            .navigationTitle("ScrollView & Lazy Containers")
    }
}

extension ScrollViewLazyContainersBootcampCoordinator {
    func viewForRouter(router: Router.ScrollViewLazyContainersRouter) -> some View {
        switch router {
        case .exampleSubview:
            EmptyView()
        }
    }
}
