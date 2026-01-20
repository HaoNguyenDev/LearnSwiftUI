//
//  ViewIdentityBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/1/26.
//

import SwiftUI

extension Router {
    enum ViewIdentityRouter: String, Routable {
        case exampleView
        var id: String { self.rawValue }
    }
}

struct ViewIdentityBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.ViewIdentityRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        ViewIdentityBootcamp()
            .navigationTitle("VIEW IDENTITY & DIFFING SYSTEM")
    }
}

extension ViewIdentityBootcampCoordinator {
    func viewForRouter(router: Router.ViewIdentityRouter) -> some View {
        switch router {
        case .exampleView: EmptyView()
        }
    }
}
