//
//  GeometryReaderCoordinateSpaceBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

extension Route {
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
    typealias ScreenRoute = Route.GeometryReaderCoordinateSpaceRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    private func getView() -> some View {
        GeometryReaderBootcamp()
            .navigationDestination(for: ScreenRoute.self, destination: { router in
                    viewForRoute(route: router)
            })
            .navigationTitle("GeometryReader & coordinateSpace")
    }
}

extension GeometryReaderCoordinateSpaceBootcampCoordinator {
    func viewForRoute(route: Route.GeometryReaderCoordinateSpaceRouter) -> some View {
        switch route {
        case .exampleSubview:
            EmptyView()
        }
    }
}
