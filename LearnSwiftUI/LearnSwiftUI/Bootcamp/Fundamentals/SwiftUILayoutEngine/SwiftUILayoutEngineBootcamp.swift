//
//  SwiftUILayoutSystemBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/1/26.
//

import SwiftUI

struct SwiftUILayoutEngineBootcamp: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(SwiftUILayoutEngineLessons.all) { lesson in
                    CodePreviewContainer(
                        title: lesson.title,
                        code: lesson.code,
                        resultView: lesson.result?()
                    )
                }
            }
            .padding()
        }  /// ScrollView
    }
}

#Preview {
    SwiftUILayoutEngineBootcamp()
}
