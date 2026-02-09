//
//  ModifiersViewProtocolCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/2/26.
//

import SwiftUI

struct ModifiersViewProtocolBootcamp: View {
    private let lessons = ModifiersViewProtocolLesson.all
    var body: some View {
        lessonScrollView(lessons)
    }
}

extension Route {
    enum ModifiersViewProtocolRoute: String, CaseIterable, Routable {
        case demo1 = "Demo 1"
        var id: String { rawValue }
    }
}

struct ModifiersViewProtocolCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.ModifiersViewProtocolRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("Modifiers & View Protocol Deep Dive")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    private var contentView: some View {
        ModifiersViewProtocolBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension ModifiersViewProtocolCoordinator {
    func viewForRoute(route: Route.ModifiersViewProtocolRoute) -> some View {
        switch route {
        case .demo1: EmptyView()
        }
    }
}
