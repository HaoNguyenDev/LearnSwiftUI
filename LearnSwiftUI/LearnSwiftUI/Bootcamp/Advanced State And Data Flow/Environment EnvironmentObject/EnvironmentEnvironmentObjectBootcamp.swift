//
//  EnvironmentEnvironmentObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/2/26.
//

import SwiftUI

struct EnvironmentEnvironmentObjectBootcamp: View {
    private let lessons = EnvironmentEnvironmentObjectLesson.all
    
    var body: some View {
        lessonScrollView(lessons)
    }
}

extension Route {
    enum EnvironmentEnvironmentObjectRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        var id: String { rawValue }
    }
}

struct EnvironmentEnvironmentObjectCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.EnvironmentEnvironmentObjectRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        content
            .customNavigationTitle("Environment EnvironmentObject")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    private var content: some View {
        EnvironmentEnvironmentObjectBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension EnvironmentEnvironmentObjectCoordinator {
    func viewForRoute(route: Route.EnvironmentEnvironmentObjectRoute) -> some View {
        EmptyView()
    }
}
