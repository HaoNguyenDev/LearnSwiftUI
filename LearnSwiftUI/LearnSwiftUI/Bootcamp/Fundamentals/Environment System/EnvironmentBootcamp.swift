//
//  EvironmentBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/2/26.
//

import SwiftUI

struct EnvironmentBootcamp: View {
    private let lesson = EnvironmentLesson.all
    
    var body: some View {
        lessonScrollView(lesson)
    }
}

extension Route {
    enum EnvironmentRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        
        var id: String { rawValue }
    }
}

struct EnvironmentCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.EnvironmentRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("Evironment System")
            .defaultNavBackButton {
                navRoute.pop(animate: true)
            }
    }
    
    private var contentView: some View {
        EnvironmentBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension EnvironmentCoordinator {
    func viewForRoute(route: ScreenRoute) -> some View {
        EmptyView()
    }
}
