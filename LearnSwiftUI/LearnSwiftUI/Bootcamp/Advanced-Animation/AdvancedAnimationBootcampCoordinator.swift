//
//  AdvancedAnimationBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/1/26.
//

import SwiftUI

extension Router {
    enum AdvancedAnimationBootcampRoute: String, CaseIterable, Routable {
        case stickyHeader
        
        var id: String { rawValue }
        var title: String {
            switch self {
            case .stickyHeader: "Sticky Header View"
            }
        }
    }
}

struct AdvancedAnimationBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.AdvancedAnimationBootcampRoute
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
            .navigationTitle("Advanced Animation")
    }
    
    @ViewBuilder
    private func getView() -> some View {
        AdvancedAnimationBootcamp(gotoDemo: { demo in
            navRouter.push(demo, animate: true)
        })
        .navigationDestination(for: ScreenRouter.self) { route in
            viewForRouter(router: route)
        }
    }
}

extension AdvancedAnimationBootcampCoordinator {
    func viewForRouter(router: Router.AdvancedAnimationBootcampRoute) -> some View {
        switch router {
        case .stickyHeader:
            StickyListView()
        }
    }
}
