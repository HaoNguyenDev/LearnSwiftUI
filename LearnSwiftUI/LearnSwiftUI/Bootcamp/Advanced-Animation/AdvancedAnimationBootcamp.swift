//
//  AdvancedAnimationBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/1/26.
//

import SwiftUI

enum AdvancedAnimationDemoType: String, CaseIterable, Identifiable, Hashable {
    case matchedGeometryEffect
    case timelineAnimation
    case phaseAnimation
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .matchedGeometryEffect: "matchedGeometryEffect demo"
        case .timelineAnimation: "timelineAnimation demo"
        case .phaseAnimation: "phaseAnimation demo"
        }
    }
    
    var demo: [Route.AdvancedAnimationBootcampRoute] {
        switch self {
        case .matchedGeometryEffect: [Route.AdvancedAnimationBootcampRoute.basicExample, Route.AdvancedAnimationBootcampRoute.tabbar, Route.AdvancedAnimationBootcampRoute.cardExpansionExample]
        case .timelineAnimation: [Route.AdvancedAnimationBootcampRoute.basicExample]
        case .phaseAnimation: [Route.AdvancedAnimationBootcampRoute.basicExample]
        }
    }
}

struct AdvancedAnimationBootcamp: View {
    var gotoDemo: SingleResult<Route.AdvancedAnimationBootcampRoute>?
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(AdvancedAnimationLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack(spacing: 24.0) {
                ForEach(AdvancedAnimationDemoType.allCases) { type in
                    Section {
                        demoSection(type: type)
                    } header: {
                        Text(type.title)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                    }
                }
                
            }
        }
    }
}

extension AdvancedAnimationBootcamp {

    @ViewBuilder
    private func demoSection(type: AdvancedAnimationDemoType) -> some View {
        LazyVStack {
            ForEach(type.demo) { demo in
                demoTitle(demo.title)
                    .onTapGesture {
                        gotoDemo?(demo)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func demoTitle(_ title: String) -> some View {
        Text(title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
}
