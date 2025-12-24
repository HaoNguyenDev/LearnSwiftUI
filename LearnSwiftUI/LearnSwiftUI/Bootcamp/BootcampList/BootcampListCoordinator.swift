//
//  BootcampListCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

extension Router {
    enum BootcampList: Routable {
        case subview
        
        var id: String {
            switch self {
            case .subview: return "BootcampList.subview"
            }
        }
    }
}

struct BootcampListCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.BootcampList
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
    }
    
    @ViewBuilder
    func getView() -> some View {
        BootcampListView(bootcampOnTap: { bootcamp in
            debugPrint("\(bootcamp.rawValue)")
        })
        // TODO: Handle goto another view with callback
    }
}

extension BootcampListCoordinator {
    func viewForRouter(router: Router.BootcampList) -> some View {
        switch router {
        case .subview:
            EmptyView()
        }
    }
}
