//
//  TextBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//


import SwiftUI

struct TextBootcamp: View {

    var body: some View {
        Spacer()
        ScrollView {
            VStack(spacing: 24) {
                ForEach(TextLessons.all) { lesson in
                    CodePreviewContainer(
                        title: lesson.title,
                        code: lesson.code,
                        resultView: lesson.result?()
                    )
                }
            }
            .padding()
        }
    }
}

#Preview {
    TextBootcamp()
}
