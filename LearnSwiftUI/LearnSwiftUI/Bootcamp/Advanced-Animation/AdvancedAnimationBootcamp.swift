//
//  AdvancedAnimationBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/1/26.
//

import SwiftUI

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
                ForEach(Route.AdvancedAnimationBootcampRoute.allCases) { demo in
                    Section {
                        demoTitle(demo.title)
                            .onTapGesture {
                                gotoDemo?(demo)
                            }
                    } header: {
                        Text(demo.sectionTitle)
                    }
                }
                
            }
        }
    }
}

extension AdvancedAnimationBootcamp {

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
