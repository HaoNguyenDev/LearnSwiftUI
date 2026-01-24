//
//  RenderingPerformanceBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 23/1/26.
//

import SwiftUI

struct RenderingPerformanceBootcamp: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(RenderingPerformanceLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
        }
    }
}

#Preview {
    RenderingPerformanceBootcamp()
}

