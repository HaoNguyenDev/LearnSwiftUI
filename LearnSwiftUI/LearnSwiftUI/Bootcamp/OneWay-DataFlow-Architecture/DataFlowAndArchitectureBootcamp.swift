//
//  DataFlowAndArchitectureBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/1/26.
//

import SwiftUI

struct DataFlowAndArchitectureBootcamp: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(DataFlowAndArchitectureLesson.all, id: \.id) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
        }
    }
}
