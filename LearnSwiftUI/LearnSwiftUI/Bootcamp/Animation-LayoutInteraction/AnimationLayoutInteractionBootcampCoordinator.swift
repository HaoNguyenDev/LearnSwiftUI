//
//  AnimationLayoutInteractionBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

extension Router {
    enum AnimationLayoutInteractionRouter: String, Routable {
        case exampleSubview
        
        var id: String { self.rawValue }
    }
}

struct AnimationLayoutInteractionBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.AnimationLayoutInteractionRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        AnimationLayoutInteractionBootcamp()
            .navigationDestination(for: ScreenRouter.self, destination: { router in
                    viewForRouter(router: router)
            })
            .navigationTitle("ANIMATION & LAYOUT INTERACTION")
    }
}

extension AnimationLayoutInteractionBootcampCoordinator {
    func viewForRouter(router: Router.AnimationLayoutInteractionRouter) -> some View {
        switch router {
        case .exampleSubview:
            EmptyView()
        }
    }
}
