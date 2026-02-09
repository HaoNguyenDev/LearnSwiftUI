//
//  ViewAndAdditional.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/8/25.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

extension View {
    @ViewBuilder
    func lessonScrollView(_ lessons: [Lesson]) -> some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(lessons) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
        }
    }
}
