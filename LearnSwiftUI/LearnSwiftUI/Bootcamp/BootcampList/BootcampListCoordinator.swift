//
//  BootcampListCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

extension Route {
    enum BootcampListRoute: String, CaseIterable, Routable {
        var id: String { rawValue }
        
        // FUNDAMENTALS
        case swiftuiLayoutEngine = "SwiftUI Layout Engine"
        case swiftuiArchitectureAndViewLifeCycle = "SwiftUI Architecture - View LifeCycle"
        case stateManagementDeepDive = "State Management Deep Dive (@State, @Binding)"
        case viewCompositionAndViewBuilder = "View Composition - ViewBuilder"
        case modifiersViewProtocol = "Modifiers & View Protocol Deep Dive"
        
        // ADVANCED STATE AND DATA FLOW
        case environmentSystem = "Environment System"
        case stateObjectObservedObject = "@ObservableObject, @StateObject, @ObservedObject"
        case environmentEnvironmentObject = "Environment EnvironmentObject"
        case observableMacro = "Observable Macro"
        case appStorageAndSceneStorage = "@AppStorage @SceneStorage"
        
        // LAYOUT & ANIMATION
        case safeAreaInsets = "SafeArea & Insets"
        case alignmentAlignmentGuide = "Alignment-AlignmentGuide"
        case geometryReaderCoordinateSpace = "GeometryReader-CoordinateSpace"
        case animationLayoutInteraction = "Animation-Layout Interaction"
        case advancedAnimation = "Advanced Animation"
        
        // LISTS, GRIDS & NAVIGATION
        case stackView = "Layout System - Stack View"
        case scrollViewLazyContainers = "ScrollView-Lazy containers"
        case navigation = "Navigation"
        
        // PERFORMANCE OPTIMIZATION
        case viewIdentity = "View Identity & Diffing System"
        case equatableview = "EquatableView"
        case someViewAnyViewAndViewBuilder = "some View - AnyView - @ViewBuilder"
        case renderingPerformance = "Rendering & Performance"
        
        // OTHERS
        case dataFlowAndArchitecture = "One-Way Data Flow and Architecture"
        case text = "Text"
        case shape = "Shape"
        case color = "Color"
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
        case .viewCompositionAndViewBuilder:
            ViewCompositionAndViewBuilderCoordinator(navRoute: navRoute)
        case .stackView:
            StackViewBootcampCoordinator(navRouter: navRoute)
        case .modifiersViewProtocol:
            ModifiersViewProtocolCoordinator(navRoute: navRoute)
        case .environmentSystem:
            EnvironmentCoordinator(navRoute: navRoute)
        case .stateObjectObservedObject:
            StateObjectObservedObjectCoordinator(navRoute: navRoute)
        case .appStorageAndSceneStorage:
            AppStorageAndSceneStorageCoordinator(navRoute: navRoute)
        case .environmentEnvironmentObject:
            EnvironmentEnvironmentObjectCoordinator(navRoute: navRoute)
        case .observableMacro:
            ObservableMacroCoordinator(navRoute: navRoute)
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
