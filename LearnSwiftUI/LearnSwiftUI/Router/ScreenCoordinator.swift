//
//  MScreenCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

protocol ScreenCoordinator {
    associatedtype ScreenRouter
    associatedtype Screen: View

    var navRouter: NavRouterProtocol { get set }
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> Screen
}

//extension ScreenCoordinator {
//    @ViewBuilder
//    func viewForRouter(router: ScreenRouter) -> some View {
//        EmptyView()
//        fatalError("ViewForRouter not implemented for \(type(of: self)) and router \(router).")
//    }
//}

