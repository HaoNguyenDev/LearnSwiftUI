//
//  BootcampListCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

extension Route {
    enum BootcampListRoute: String, CaseIterable, Routable {
        case swiftuiLayoutEngine
        case swiftuiArchitectureAndViewLifeCycle
        case viewIdentity
        case stateManagementDeepDive
        case someViewAnyViewAndViewBuilder
        case stackView
        case alignmentAlignmentGuide
        case geometryReaderCoordinateSpace
        case scrollViewLazyContainers
        case safeAreaInsets
        case animationLayoutInteraction
        case dataFlowAndArchitecture
        case renderingPerformance
        case equatableview
        case navigation
        case advancedAnimation
        case text
        case shape
        case color
        var id: String { rawValue }
        
        var title: String {
            switch self {
            case .swiftuiLayoutEngine: "SwiftUI Layout Engine"
            case .swiftuiArchitectureAndViewLifeCycle: "SwiftUI Architecture - View LifeCycle"
            case .stateManagementDeepDive: "State Management Deep Dive (@State, @Binding)"
            case .someViewAnyViewAndViewBuilder: "some View - AnyView - @ViewBuilder"
            case .stackView: "Stack View"
            case .alignmentAlignmentGuide: "Alignment-AlignmentGuide"
            case .geometryReaderCoordinateSpace: "GeometryReader-CoordinateSpace"
            case .scrollViewLazyContainers: "ScrollView-Lazy containers"
            case .safeAreaInsets: "SafeArea & Insets"
            case .animationLayoutInteraction: "Animation-Layout Interaction"
            case .viewIdentity: "View Identity & Diffing System"
            case .dataFlowAndArchitecture: "One-Way Data Flow and Architecture"
            case .renderingPerformance: "Rendering & Performance"
            case .equatableview: "EquatableView"
            case .navigation: "Navigation"
            case .advancedAnimation: "Advanced Animation"
            case .text: "Text"
            case .shape: "Shape"
            case .color: "Color"
            }
        }
    }
}

struct BootcampListCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.BootcampListRoute
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
            getView()
                .navigationBarTitle("SwiftUI Bootcamp")
                .navigationDestination(for: ScreenRoute.self) { router in
                    viewForRoute(route: router)
                }
                .toolbar(.hidden, for: .bottomBar)
                .toolbar(.hidden, for: .tabBar)
    }
    
    @ViewBuilder
    func getView() -> some View {
        BootcampListView(selectedRoute: { bootcamp in
            debugPrint("\(bootcamp.rawValue)")
            navRoute.push(bootcamp, animate: true)
        })
    }
}

extension BootcampListCoordinator {
    @ViewBuilder
    func viewForRoute(route: ScreenRoute) -> some View {
        switch route {
        case .swiftuiLayoutEngine:
            SwiftUILayoutEngineCoordinator(navRouter: navRoute)
        case .swiftuiArchitectureAndViewLifeCycle:
            SwiftUIArchitectureAndViewLifeCycleCoordinator(navRoute: navRoute)
        case .someViewAnyViewAndViewBuilder:
            SomeViewAnyViewAndViewBuilderCoordinator(navRoute: navRoute)
        case .viewIdentity:
            ViewIdentityBootcampCoordinator(navRouter: navRoute)
        case .stateManagementDeepDive:
            StateManagementDeepDiveCoordinator(navRoute: navRoute)
        case .stackView:
            StackViewBootcampCoordinator(navRouter: navRoute)
        case .alignmentAlignmentGuide:
            AlignmentBootcampCoordinator(navRouter: navRoute)
        case .geometryReaderCoordinateSpace:
            GeometryReaderCoordinateSpaceBootcampCoordinator(navRouter: navRoute)
        case .scrollViewLazyContainers:
            ScrollViewLazyContainersBootcampCoordinator(navRouter: navRoute)
        case .safeAreaInsets:
            SafeAreaInsetsBootcampCoordinator(navRouter: navRoute)
        case .animationLayoutInteraction:
            AnimationLayoutInteractionBootcampCoordinator(navRouter: navRoute)
        case .dataFlowAndArchitecture:
            DataFlowAndArchitectureCoordinator(navRouter: navRoute)
        case .renderingPerformance:
            RenderignPerformanceBootcampCoordinator(navRouter: navRoute)
        case .equatableview:
            EquatableViewBootcampCoordinator(navRouter: navRoute)
        case .navigation:
            NavigationBootcampCoordinator(navRouter: navRoute)
        case .advancedAnimation:
            AdvancedAnimationBootcampCoordinator(navRouter: navRoute)
        case .text:
            TextBootcampCoordinator(navRouter: navRoute)
        case .shape, .color:
            EmptyView()
        }
    }
}

struct PreviewBootcamp: View {
    @State private var navRoute = NavRoute()
    var body: some View {
        NavigationStack(path: $navRoute.path) {
            BootcampListCoordinator(navRouter: navRoute)
        }
    }
}
#Preview {
    PreviewBootcamp()
}
