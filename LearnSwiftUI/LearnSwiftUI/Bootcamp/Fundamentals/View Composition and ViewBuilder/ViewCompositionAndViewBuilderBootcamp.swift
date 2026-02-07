//
//  ViewCompositionAndViewBuilderBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/2/26.
//

import SwiftUI

struct ViewCompositionAndViewBuilderBootcamp: View {
    var gotoDemo: SingleResult<Route.ViewCompositionAndViewBuilder>?
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(ViewCompositionAndViewBuilderLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            ForEach(Route.ViewCompositionAndViewBuilder.allCases) { demo in
                demoTitle(demo.rawValue)
                    .onTapGesture {
                        gotoDemo?(demo)
                    }
            }
        }
    }
}
