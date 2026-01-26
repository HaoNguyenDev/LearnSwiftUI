//
//  EquatableViewBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/1/26.
//

import SwiftUI

extension Router {
    enum EquatableViewRouter: String, CaseIterable, Routable {
        case equatableViewDemo
        var id: String { self.rawValue }
        var title: String {
            switch self {
            case .equatableViewDemo: "EquatableView Demo"
            }
        }
    }
}

struct EquatableViewBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.EquatableViewRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        EquatableViewBootcamp(gotoDemo: { demo in
            navRouter.push(demo, animate: true)
        })
        .navigationDestination(for: ScreenRouter.self, destination: { router in
            viewForRouter(router: router)
        })
        .navigationTitle("EquatableView")
    }
}

extension EquatableViewBootcampCoordinator {
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .equatableViewDemo: EquatableViewDemo()
        }
    }
}

struct TestEquatableBootcamp: View {
    @State private var root: NavRouter
    
    init() {
        self.root = NavRouter()
    }
    
    var body: some View {
        NavigationStack(path: $root.path) {
            EquatableViewBootcampCoordinator(navRouter: root)
        }
    }
}

#Preview {
    TestEquatableBootcamp()
}
