//
//  SwiftUIPropertyWrapperBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 12/2/26.
//

import SwiftUI

struct SwiftUIPropertyWrapperBootcamp: View {
    private let lesson = SwiftUIPropertyWrapperLesson.all
    
    var body: some View {
        lessonScrollView(lesson)
    }
}

extension Route {
    enum SwiftUIPropertyWrapperRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        var id: String { rawValue }
    }
}

struct SwiftUIPropertyWrapperCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.SwiftUILayoutEngineRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        content
            .customNavigationTitle("SwiftUI Property Wrapper")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    var content: some View {
        SwiftUIPropertyWrapperBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension SwiftUIPropertyWrapperCoordinator {
    func viewForRoute(route: Route.SwiftUILayoutEngineRoute) -> some View {
        Text("Not implement yet!")
    }
}
