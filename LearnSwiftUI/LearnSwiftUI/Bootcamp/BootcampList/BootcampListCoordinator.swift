//
//  BootcampListCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

extension Router {
    enum BootcampListRouter: String, Routable {
        case swiftuiLayoutEngine
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
        var id: String { self.rawValue }
    }
}

struct BootcampListCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.BootcampListRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
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
                navRouter.push(ScreenRouter.swiftuiLayoutEngine, animate: true)
            case .stackView:
                navRouter.push(ScreenRouter.stackViewBootcamp, animate: true)
            case .alignmentAlignmentGuide:
                navRouter.push(ScreenRouter.alignmentAlignmentGuide, animate: true)
            case .geometryReaderCoordinateSpace:
                navRouter.push(ScreenRouter.geometryReaderCoordinateSpace, animate: true)
            case .scrollViewLazyContainers:
                navRouter.push(ScreenRouter.scrollViewLazyContainers, animate: true)
            case .safeAreaInsets:
                navRouter.push(ScreenRouter.safeAreaInsets, animate: true)
            case .animationLayoutInteraction:
                navRouter.push(ScreenRouter.animationLayoutInteraction, animate: true)
            case .viewIdentity:
                navRouter.push(ScreenRouter.viewIndentity, animate: true)
            case .dataFlowAndArchitecture:
                navRouter.push(ScreenRouter.dataFlowAndArchitecture, animate: true)
            case .renderingPerformance:
                navRouter.push(ScreenRouter.renderingPerformance, animate: true)
            case .text:
                navRouter.push(ScreenRouter.textBootcamp, animate: true)
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
    func viewForRouter(router: Router.BootcampListRouter) -> some View {
        switch router {
        case .swiftuiLayoutEngine:
            SwiftUILayoutEngineCoordinator(navRouter: navRouter)
        case .stackViewBootcamp:
            StackViewBootcampCoordinator(navRouter: navRouter)
        case .alignmentAlignmentGuide:
            AlignmentBootcampCoordinator(navRouter: navRouter)
        case .geometryReaderCoordinateSpace:
            GeometryReaderCoordinateSpaceBootcampCoordinator(navRouter: navRouter)
        case .scrollViewLazyContainers:
            ScrollViewLazyContainersBootcampCoordinator(navRouter: navRouter)
        case .safeAreaInsets:
            SafeAreaInsetsBootcampCoordinator(navRouter: navRouter)
        case .animationLayoutInteraction:
            AnimationLayoutInteractionBootcampCoordinator(navRouter: navRouter)
        case .viewIndentity:
            ViewIdentityBootcampCoordinator(navRouter: navRouter)
        case .dataFlowAndArchitecture:
            DataFlowAndArchitectureCoordinator(navRouter: navRouter)
        case .renderingPerformance:
            RenderignPerformanceBootcampCoordinator(navRouter: navRouter)
        case .textBootcamp:
            TextBootcampCoordinator(navRouter: navRouter)
        }
    }
}

