//
//  StateObjectObservedObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 12/2/26.
//

import SwiftUI

struct StateObjectObservedObjectBootcamp: View {
    private let lesson = StateObjectObservedObjectLesson.all
    
    var body: some View {
        lessonScrollView(lesson)
    }
}

extension Route {
    enum StateObjectObservedObjectRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        var id: String { rawValue }
    }
}

struct StateObjectObservedObjectCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.SwiftUILayoutEngineRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        content
            .customNavigationTitle("@Observable, @StateObject, @ObservedObject")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    var content: some View {
        StateObjectObservedObjectBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension StateObjectObservedObjectCoordinator {
    func viewForRoute(route: Route.SwiftUILayoutEngineRoute) -> some View {
        Text("Not implement yet!")
    }
}
