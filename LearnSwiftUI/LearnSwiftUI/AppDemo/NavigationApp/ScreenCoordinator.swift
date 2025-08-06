//
//  ScreenCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//


import SwiftUI

protocol ScreenCoordinator {
    associatedtype ScreenRouter
    associatedtype Screen: View

    var navRouter: NavRouterProtocol { get set }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> Screen
}
