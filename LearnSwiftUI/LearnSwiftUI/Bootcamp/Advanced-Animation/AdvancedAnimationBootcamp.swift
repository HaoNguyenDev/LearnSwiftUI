//
//  AdvancedAnimationBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/1/26.
//

import SwiftUI

struct AdvancedAnimationBootcamp: View {
    var gotoDemo: SingleResult<Router.AdvancedAnimationBootcampRoute>?
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(AdvancedAnimationLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack(spacing: 24.0) {
                ForEach(Router.AdvancedAnimationBootcampRoute.allCases) { demo in
                    demoTitle(demo: demo)
                }
            }
        }
    }
}

extension AdvancedAnimationBootcamp {

    @ViewBuilder
    private func demoTitle(demo: Router.AdvancedAnimationBootcampRoute) -> some View {
        Text(demo.title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .onTapGesture {
                gotoDemo?(demo)
            }
    }
}
