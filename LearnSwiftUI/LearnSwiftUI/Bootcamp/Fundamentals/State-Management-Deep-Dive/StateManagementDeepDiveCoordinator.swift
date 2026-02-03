//
//  StateManagementDeepDiveCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

extension Route {
    enum StateManagementDeepDiveRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        
        var id: String { rawValue }
    }
}
struct StateManagementDeepDiveCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.StateManagementDeepDiveRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        contentView
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("State Management Deep Dive")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.black, .gray],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        Text("(@State, @Binding)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        StateManagementDeepDiveBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension StateManagementDeepDiveCoordinator {
    func viewForRoute(route: ScreenRoute) -> some View {
        EmptyView()
    }
}
