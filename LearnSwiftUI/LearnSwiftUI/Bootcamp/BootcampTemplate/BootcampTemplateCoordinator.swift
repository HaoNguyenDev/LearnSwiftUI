//
//  BootcampTemplateCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/1/26.
//

import SwiftUI

extension Router {
    enum BootcampTemplateRouter: String, CaseIterable, Routable {
        case childView1
        case childView2
        var id: String { self.rawValue }
        var title: String {
            switch self {
            case .childView1: "Child View 1"
            case .childView2: "Child View 2"
            }
        }
    }
}
struct BootcampTemplateCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.BootcampTemplateRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        BootcampTemplateView() { child in
            switch child {
            case .childView1:
                navRouter.push(ScreenRouter.childView1, animate: true)
            case .childView2:
                navRouter.push(ScreenRouter.childView2, animate: true)
            }
        }
        .navigationDestination(for: ScreenRouter.self, destination: { router in
            viewForRouter(router: router)
        })
        .navigationTitle("Bootcamp Template")
    }
}

extension BootcampTemplateCoordinator {
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .childView1: Text(router.title)
        case .childView2: Text(router.title)
        }
    }
}

struct RootDemo: View {
    @State private var nav = NavRouter()
    
    var body: some View {
        NavigationStack(path: $nav.path) {
            BootcampTemplateCoordinator(navRouter: nav)
        }
    }
}
#Preview {
    RootDemo()
}
