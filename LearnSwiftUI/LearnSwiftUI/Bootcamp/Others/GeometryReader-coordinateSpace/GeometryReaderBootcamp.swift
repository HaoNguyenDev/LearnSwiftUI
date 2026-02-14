//
//  GeometryReaderBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    @State private var selectedDemo: GeometryReaderDemos?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24.0) {
                ForEach(GeometryReaderCoordinateSpaceLessons.all) { lesson in
                    CodePreviewContainer(title: lesson.title,
                                         code: lesson.code,
                                         resultView: lesson.result?())
                }
            }
            
            demoSection()

        }
        .sheet(item: $selectedDemo) { demo in
            destinationView(demo: demo)
        }
    }
    
    private func demoSection() -> some View {
        Section {
            VStack {
                ForEach(GeometryReaderDemos.allCases, id: \.self) { demo in
                    demoTitleView(demo: demo)
                }
            }
        } header: {
            VStack(alignment: .leading) {
                Text("GeometryReader Demo")
                            .font(.title2)
                            .bold()
                            .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
    
    private func demoTitleView(demo: GeometryReaderDemos) -> some View {
        Text(demo.title)
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                debugPrint("\(demo.title)")
                selectedDemo = demo
            }
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private func destinationView(demo: GeometryReaderDemos) -> some View {
        switch demo {
        case .stickyHeader:
            StickyHeaderViewDemo()
        case .parallaxEffect:
            ParallaxViewDemo()
        case .collapseToolbar:
            CollapseToolbarViewDemo()
        case .scrollBasedAnimation:
            ScrollAnimationViewDemo()
        case .measureTheSize:
            MeasureSizeViewDemo()
        case .customPaging:
            PagingViewDemo()
        case .dragGesture:
            DragViewDemo()
        }
    }
}

