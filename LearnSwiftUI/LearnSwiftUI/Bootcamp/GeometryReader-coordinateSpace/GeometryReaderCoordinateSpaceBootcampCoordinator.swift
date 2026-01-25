//
//  GeometryReaderCoordinateSpaceBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

extension Router {
    enum GeometryReaderCoordinateSpaceRouter: Routable {
        case exampleSubview
        
        var id: String {
            switch self {
            case .exampleSubview:
                return "GeometryReaderCoordinateSpace.exampleSubview"
            }
        }
    }
}

struct GeometryReaderCoordinateSpaceBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.GeometryReaderCoordinateSpaceRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        GeometryReaderBootcamp()
            .navigationDestination(for: ScreenRouter.self, destination: { router in
                    viewForRouter(router: router)
            })
            .navigationTitle("GeometryReader & coordinateSpace")
    }
}

extension GeometryReaderCoordinateSpaceBootcampCoordinator {
    func viewForRouter(router: Router.GeometryReaderCoordinateSpaceRouter) -> some View {
        switch router {
        case .exampleSubview:
            EmptyView()
        }
    }
}
