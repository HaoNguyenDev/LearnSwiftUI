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
    case others = "Others"
    
    var id: String { rawValue }
    var title: String { rawValue }
    var routes: [Route.BootcampListRoute] {
        switch self {
        case .fundamentals: [Route.BootcampListRoute.swiftuiLayoutEngine,
                             Route.BootcampListRoute.swiftuiArchitectureAndViewLifeCycle,
                             Route.BootcampListRoute.viewIdentity,
                             Route.BootcampListRoute.someViewAnyViewAndViewBuilder,
                             Route.BootcampListRoute.renderingPerformance,
                             Route.BootcampListRoute.equatableview]
        case .advancedStateAndDataFlow: [Route.BootcampListRoute.dataFlowAndArchitecture]
        case .others: [Route.BootcampListRoute.stackView,
                       Route.BootcampListRoute.alignmentAlignmentGuide,
                       Route.BootcampListRoute.geometryReaderCoordinateSpace,
                       Route.BootcampListRoute.scrollViewLazyContainers,
                       Route.BootcampListRoute.safeAreaInsets,
                       Route.BootcampListRoute.animationLayoutInteraction,
                       Route.BootcampListRoute.navigation,
                       Route.BootcampListRoute.advancedAnimation,
                       Route.BootcampListRoute.text,
                       Route.BootcampListRoute.shape,
                       Route.BootcampListRoute.color]
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
        NavigationView {
            bootcampList
                .navigationBarTitle("SwiftUI Bootcamp List")
        }
    }
    
    private var bootcampList: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                ForEach(BootcampSection.allCases, id: \.id) { section in
                    Section {
                        bootcampSection(routes: section.routes)
                    } header: {
                        VStack(alignment: .leading) {
                            Text(section.title)
                                .foregroundStyle(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                                .padding([.leading])
                                
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
}

extension BootcampListView {
    @ViewBuilder
    private func bootcampSection(routes: [Route.BootcampListRoute]) -> some View {
        LazyVStack {
            ForEach(routes, id: \.id) { route in
                bootcampTitle(route.title)
                    .onTapGesture {
                        selectedRoute?(route)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func bootcampTitle(_ title: String) -> some View {
        Text(title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
}
#Preview {
    BootcampListView()
}
