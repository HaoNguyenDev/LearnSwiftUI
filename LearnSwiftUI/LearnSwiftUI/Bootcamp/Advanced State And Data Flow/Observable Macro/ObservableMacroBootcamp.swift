//
//  ObservableMacroBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/2/26.
//

import SwiftUI

struct ObservableMacroBootcamp: View {
    var onDemo: SingleResult<Route.ObservableMacroRoute>?
    var body: some View {
        ScrollView {
            lessonPath
            demoPath
        }
    }
    
    private var lessonPath: some View {
        LazyVStack(spacing: 24.0) {
            ForEach(ObservableMacroLesson.all, id: \.id) { lesson in
                CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
            }
        }
    }
    
    private var demoPath: some View {
        VStack {
            ForEach(Route.ObservableMacroRoute.allCases, id: \.id) { demo in
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
    enum ObservableMacroRoute: String, CaseIterable, Routable {
        case demo1 = "Observable Macro excercies"
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
        ObservableMacroBootcamp(onDemo: { route in
            navRoute.push(route, animate: true)
        })
        .navigationDestination(for: ScreenRoute.self) { route in
            viewForRoute(route: route)
        }
    }
}

extension ObservableMacroCoordinator {
    func viewForRoute(route: Route.ObservableMacroRoute) -> some View {
        switch route {
        case .demo1: TaskStoreViewCoordinator(navRoute: navRoute)
        }
    }
}
