//
//  BindingAdvancedPatternsBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 16/2/26.
//

import SwiftUI

struct BindingAdvancedPatternsBootcamp: View {
    var body: some View {
        lessonScrollView(BindingAdvancedPatternLesson.all)
    }
}

extension Route {
    enum BindingAdvancedPatternRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        var id: String { rawValue }
    }
}

struct BindingAdvancedPatternCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.BindingAdvancedPatternRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        content
            .customNavigationTitle("Binding Advanced Patterns")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    private var content: some View {
        BindingAdvancedPatternsBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension BindingAdvancedPatternCoordinator {
    func viewForRoute(route: Route.BindingAdvancedPatternRoute) -> some View {
        Text("Not implement yet!")
    }
}
