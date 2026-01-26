//
//  NavigationBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/1/26.
//

import SwiftUI

extension Router {
    enum NavigationRouter: String, CaseIterable, Routable {
        case demo1
        
        var id: String { self.rawValue }
        var title: String {
            switch self {
            case .demo1: "Demo 1"
            }
        }
    }
}
struct NavigationBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.NavigationRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        NavigationBootcamp(gotoDemo: { demo in
            switch demo {
            case .demo1:
                navRouter.push(ScreenRouter.demo1, animate: true)
            }
        })
        .navigationDestination(for: ScreenRouter.self) { router in
            viewForRouter(router: router)
        }
        .navigationTitle("Navigation Bootcamp")
    }
    
}

extension NavigationBootcampCoordinator {
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .demo1: Text("Demo 1")
        }
    }
}

struct NaviationBootcampRootView: View {
    @State private var nav: NavRouter
    
    init() {
        self.nav = NavRouter()
    }
    var body: some View {
        NavigationStack(path: $nav.path) {
            NavigationBootcampCoordinator(navRouter: nav)
        }
    }
}

#Preview(body: {
    NaviationBootcampRootView()
})
