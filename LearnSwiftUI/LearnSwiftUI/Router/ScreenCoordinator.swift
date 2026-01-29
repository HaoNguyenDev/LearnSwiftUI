//
//  MScreenCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

protocol ScreenCoordinator {
    associatedtype ScreenRoute
    associatedtype Screen: View

    var navRoute: NavRouterProtocol { get set }
    @ViewBuilder
    func viewForRoute(route: ScreenRoute) -> Screen
}

//extension ScreenCoordinator {
//    @ViewBuilder
//    func viewForRouter(router: ScreenRouter) -> some View {
//        EmptyView()
//        fatalError("ViewForRouter not implemented for \(type(of: self)) and router \(router).")
//    }
//}

