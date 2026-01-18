//
//  AnimationLayoutInteractionBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

struct AnimationLayoutInteractionBootcamp: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(AnimationLayoutInteractionLessons.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
        }
    }
}
