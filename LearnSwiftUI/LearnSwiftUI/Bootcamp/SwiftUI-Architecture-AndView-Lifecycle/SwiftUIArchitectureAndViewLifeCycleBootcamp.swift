//
//  SwiftUIArchitectureAndViewLifeCycleBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

struct SwiftUIArchitectureAndViewLifeCycleBootcamp: View {
    var gotoDemo: SingleResult<Route.SwiftUIArchitectureAndViewLifeCycleRoute>?
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(SwiftUIArchitectureAndViewLifeCycleLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack {
                ForEach(Route.SwiftUIArchitectureAndViewLifeCycleRoute.allCases) { demo in
                    demoTitle(demo.title)
                        .onTapGesture {
                            gotoDemo?(demo)
                        }
                }
            }
        }
    }
}

extension SwiftUIArchitectureAndViewLifeCycleBootcamp {
    private func demoTitle(_ title: String) -> some View {
        Text(title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
}
