//
//  ObservableMacroBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/2/26.
//

import SwiftUI

struct ObservableMacroBootcamp: View {
    private var lessons = ObservableMacroLesson.all
    
    var body: some View {
        lessonScrollView(lessons)
    }
}

extension Route {
    enum ObservableMacroRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        var id: String { rawValue }
    }
}

struct ObservableMacroCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.ObservableMacroRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        content
            .customNavigationTitle("Observable Macro")
            .defaultNavBackButton {
                navRoute.pop(animate: true)
            }
    }
    
    private var content: some View {
        ObservableMacroBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension ObservableMacroCoordinator {
    func viewForRoute(route: Route.ObservableMacroRoute) -> some View {
        Text("Not implement yet")
    }
}
