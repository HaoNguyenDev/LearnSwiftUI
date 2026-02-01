//
//  BootcampListCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

extension Route {
    enum BootcampListRouter: String, Routable {
        case swiftuiLayoutEngine
        case swiftuiArchitectureAndViewLifeCycle
        case someViewAnyViewAndViewBuilder
        case stackViewBootcamp
        case alignmentAlignmentGuide
        case geometryReaderCoordinateSpace
        case scrollViewLazyContainers
        case safeAreaInsets
        case animationLayoutInteraction
        case viewIndentity
        case dataFlowAndArchitecture
        case textBootcamp
        case renderingPerformance
        case equatableview
        case navigation
        case advancedAnimation
        var id: String { self.rawValue }
    }
}

struct BootcampListCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.BootcampListRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRoute.self) { router in
                viewForRoute(route: router)
            }
            .toolbar(.hidden, for: .bottomBar)
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func getView() -> some View {
        BootcampListView(bootcampOnTap: { bootcamp in
            debugPrint("\(bootcamp.rawValue)")
            switch bootcamp {
            case .swiftuiLayoutSystem:
                navRoute.push(ScreenRoute.swiftuiLayoutEngine, animate: true)
            case .stackView:
                navRoute.push(ScreenRoute.stackViewBootcamp, animate: true)
            case .alignmentAlignmentGuide:
                navRoute.push(ScreenRoute.alignmentAlignmentGuide, animate: true)
            case .geometryReaderCoordinateSpace:
                navRoute.push(ScreenRoute.geometryReaderCoordinateSpace, animate: true)
            case .scrollViewLazyContainers:
                navRoute.push(ScreenRoute.scrollViewLazyContainers, animate: true)
            case .safeAreaInsets:
                navRoute.push(ScreenRoute.safeAreaInsets, animate: true)
            case .animationLayoutInteraction:
                navRoute.push(ScreenRoute.animationLayoutInteraction, animate: true)
            case .viewIdentity:
                navRoute.push(ScreenRoute.viewIndentity, animate: true)
            case .dataFlowAndArchitecture:
                navRoute.push(ScreenRoute.dataFlowAndArchitecture, animate: true)
            case .renderingPerformance:
                navRoute.push(ScreenRoute.renderingPerformance, animate: true)
            case .equatableview:
                navRoute.push(ScreenRoute.equatableview, animate: true)
            case .naviagtion:
                navRoute.push(ScreenRoute.navigation, animate: true)
            case .advancedAnimation:
                navRoute.push(ScreenRoute.advancedAnimation, animate: true)
            case .swiftuiArchitectureAndViewLifeCycle:
                navRoute.push(ScreenRoute.swiftuiArchitectureAndViewLifeCycle, animate: true)
            case .someViewAnyViewAndViewBuilder:
                navRoute.push(ScreenRoute.someViewAnyViewAndViewBuilder, animate: true)
            case .text:
                navRoute.push(ScreenRoute.textBootcamp, animate: true)
            case .shape: break
                // TODO:
            case .color: break
                // TODO:
            }
            
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
        case .stackViewBootcamp:
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
        case .viewIndentity:
            ViewIdentityBootcampCoordinator(navRouter: navRoute)
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
        case .textBootcamp:
            TextBootcampCoordinator(navRouter: navRoute)
        }
    }
}

