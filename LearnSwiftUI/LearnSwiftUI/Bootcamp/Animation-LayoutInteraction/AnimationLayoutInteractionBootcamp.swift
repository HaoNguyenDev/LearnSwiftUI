//
//  AnimationLayoutInteractionBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

enum AnimationLayoutDemo: String, Identifiable, CaseIterable {
    case expandCard
    case accordion
    case customTabBar
    case stickySectionList
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .expandCard: "Expand Card"
        case .accordion: "ACCORDION"
        case .customTabBar: "CUSTOM TAB BAR"
        case .stickySectionList: "Sticky Section List"
        }
    }
}
struct AnimationLayoutInteractionBootcamp: View {
    @State private var selectedDemo: AnimationLayoutDemo?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(AnimationLayoutInteractionLessons.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack(spacing: 24.0) {
                ForEach(AnimationLayoutDemo.allCases, id: \.id) { demo in
                    demoTitle(demo: demo)
                }
            }
        }
        .sheet(item: $selectedDemo) { demo in
            destinationView(for: demo)
        }
    }
    
    @ViewBuilder
    private func demoTitle(demo: AnimationLayoutDemo) -> some View {
        Text(demo.title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .onTapGesture {
                selectedDemo = demo
            }
    }
    
    @ViewBuilder
    private func destinationView(for demo: AnimationLayoutDemo) -> some View {
        switch demo {
        case .expandCard: ExpandCardAnimationDemo()
        case .accordion: AccordionItemDemo()
        case .customTabBar: TabBarContainerAnimationDemo()
        case .stickySectionList: StickyListView()
        }
    }
}

#Preview {
    AnimationLayoutInteractionBootcamp()
}
