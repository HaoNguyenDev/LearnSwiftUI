//
//  EnvironmentEnvironmentObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/2/26.
//

import SwiftUI

struct EnvironmentEnvironmentObjectBootcamp: View {
    var onDemo: SingleResult<Route.EnvironmentEnvironmentObjectRoute>?
    private let lessons = EnvironmentEnvironmentObjectLesson.all
    
    var body: some View {
        ScrollView {
            lessonPath
            demoPath
        }
    }
    
    private var lessonPath: some View {
        LazyVStack(spacing: 24.0) {
            ForEach(lessons, id: \.id) { lesson in
                CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
            }
        }
    }
    
    private var demoPath: some View {
        VStack {
            ForEach(Route.EnvironmentEnvironmentObjectRoute.allCases, id: \.id) { demo in
                Section {
                    demoTitle(demo.rawValue)
                        .onTapGesture {
                            onDemo?(demo)
                        }
                } header: {
                    VStack(alignment: .leading) {
                        Text("Excercies path")
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.black)
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }

            }
        }
    }
}

extension Route {
    enum EnvironmentEnvironmentObjectRoute: String, CaseIterable, Routable {
        case demo1 = "App Theme Environment Excercies"
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
        EnvironmentEnvironmentObjectBootcamp(onDemo: { route in
            navRoute.push(route, animate: true)
        })
        .navigationDestination(for: ScreenRoute.self) { route in
            viewForRoute(route: route)
        }
    }
}

extension EnvironmentEnvironmentObjectCoordinator {
    func viewForRoute(route: Route.EnvironmentEnvironmentObjectRoute) -> some View {
        switch route {
        case .demo1: AppThemeEnvironmentExcercies()
        }
    }
}
