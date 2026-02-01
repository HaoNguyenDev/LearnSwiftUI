//
//  SomeViewAnyViewAndViewBuilder.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

struct SomeViewAnyViewAndViewBuilderBootcamp: View {
    var gotoDemo: SingleResult<Route.SomeViewAnyViewAndViewBuilderRoute>?
    var body: some View {
        ScrollView {
            ForEach(SomeViewAnyViewAndViewBuilderLesson.all) { lesson in
                CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
            }
            
            ForEach(Route.SomeViewAnyViewAndViewBuilderRoute.allCases) { demo in
                demoTitle(demo.title)
                    .onTapGesture {
                        gotoDemo?(demo)
                    }
            }
        }
    }
}
