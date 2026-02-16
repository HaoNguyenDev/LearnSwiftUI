//
//  BootcampListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

enum BootcampSection: String, Identifiable, CaseIterable {
    case fundamentals = "FUNDAMENTALS"
    case advancedStateAndDataFlow = "ADVANCED STATE & DATA FLOW"
    case layoutAndAnimation = "LAYOUT AND ANIMATION"
    case listsGridsAndNavigation = "STACKS, LISTS, GRIDS & NAVIGATION"
    case performanceOptimization = "PERFORMANCE OPTIMIZATION"
    case others = "Others"
    
    var id: String { rawValue }
    var title: String { rawValue }
    var fundamentalRoutes: [Route.BootcampListRoute] {
        [Route.BootcampListRoute.swiftuiLayoutEngine,
         Route.BootcampListRoute.swiftuiArchitectureAndViewLifeCycle,
         Route.BootcampListRoute.stateManagementDeepDive,
         Route.BootcampListRoute.viewCompositionAndViewBuilder,
         Route.BootcampListRoute.modifiersViewProtocol,
        ]
    }
    
    var advancedStateAndDataFlowRoutes: [Route.BootcampListRoute] {
        [Route.BootcampListRoute.dataFlowAndArchitecture,
         Route.BootcampListRoute.stateObjectObservedObject,
         Route.BootcampListRoute.appStorageAndSceneStorage,
         Route.BootcampListRoute.environmentSystem,
         Route.BootcampListRoute.environmentEnvironmentObject,
         Route.BootcampListRoute.observableMacro,
         Route.BootcampListRoute.bindingAdvancedPatterns
        ]
    }
    
    var layoutAndAnimationRoutes: [Route.BootcampListRoute] {
        [Route.BootcampListRoute.safeAreaInsets,
         Route.BootcampListRoute.alignmentAlignmentGuide,
         Route.BootcampListRoute.geometryReaderCoordinateSpace,
         Route.BootcampListRoute.animationLayoutInteraction,
         Route.BootcampListRoute.advancedAnimation,
        ]
    }
    
    var listsGridsAndNavigationRoutes: [Route.BootcampListRoute] {
        [Route.BootcampListRoute.stackView,
         Route.BootcampListRoute.scrollViewLazyContainers,
         Route.BootcampListRoute.navigation,
        ]
    }
    
    var performanceOptimizationRoutes: [Route.BootcampListRoute] {
        [Route.BootcampListRoute.viewIdentity,
         Route.BootcampListRoute.equatableview,
         Route.BootcampListRoute.someViewAnyViewAndViewBuilder,
         Route.BootcampListRoute.renderingPerformance
        ]
    }
    
    var otherRoutes: [Route.BootcampListRoute] {
        [Route.BootcampListRoute.text,
         Route.BootcampListRoute.shape,
         Route.BootcampListRoute.color
        ]
    }
    
    var routes: [Route.BootcampListRoute] {
        switch self {
        case .fundamentals:
            fundamentalRoutes
        case .advancedStateAndDataFlow:
            advancedStateAndDataFlowRoutes
        case .layoutAndAnimation:
            layoutAndAnimationRoutes
        case .listsGridsAndNavigation:
            listsGridsAndNavigationRoutes
        case .performanceOptimization:
            performanceOptimizationRoutes
        case .others:
            otherRoutes
        }
    }
}

extension BootcampSection {
    var route: any Routable {
        Route.BootcampListRoute.self as! (any Routable)
    }
}

struct BootcampListView: View {
    @Environment(\.theme) var theme
    
    var selectedRoute: SingleResult<Route.BootcampListRoute>?
    
    var body: some View {
        bootcampList
    }
    
    private var bootcampList: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                ForEach(BootcampSection.allCases, id: \.id) { section in
                    Section {
                        bootcampSection(routes: section.routes)
                    } header: {
                        headerView(section.title)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

extension BootcampListView {
    private func bootcampSection(routes: [Route.BootcampListRoute]) -> some View {
        LazyVStack {
            ForEach(routes, id: \.id) { route in
                bootcampTitle(route.rawValue)
                    .onTapGesture {
                        selectedRoute?(route)
                    }
            }
        }
    }
    
    private func bootcampTitle(_ title: String) -> some View {
        Text(title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func headerView(_ title: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BootcampListView()
}
