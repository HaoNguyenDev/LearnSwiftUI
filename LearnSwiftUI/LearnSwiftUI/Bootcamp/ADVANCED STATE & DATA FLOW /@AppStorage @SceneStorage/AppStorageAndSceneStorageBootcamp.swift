//
//  AppStorageAndSceneStorageBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/2/26.
//

import SwiftUI

struct AppStorageAndSceneStorageBootcamp: View {
    var body: some View {
        lessonScrollView(AppStorageAndSceneStorageLesson.all)
    }
}

extension Route {
    enum AppStorageAndSceneStorageRoute: String, Routable {
        case demo1 = "Demo 1"
        
        var id: String { rawValue }
    }
}
struct AppStorageAndSceneStorageCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.AppStorageAndSceneStorageRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        content
            .customNavigationTitle("@AppStorage @SceneStorage")
            .defaultNavBackButton(onTap: {
                navRoute.pop(animate: true)
            })
    }
    
    private var content: some View {
        AppStorageAndSceneStorageBootcamp()
            .navigationDestination(for: ScreenRoute.self) { route in
                viewForRoute(route: route)
            }
    }
}

extension AppStorageAndSceneStorageCoordinator {
    func viewForRoute(route: Route.AppStorageAndSceneStorageRoute) -> some View {
        Text("Not implement yet!")
    }
}
