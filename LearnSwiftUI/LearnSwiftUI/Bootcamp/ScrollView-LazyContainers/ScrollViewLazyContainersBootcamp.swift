//
//  ScrollViewLazyContainersBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/1/26.
//

import SwiftUI

struct ScrollViewLazyContainersBootcamp: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24.0) {
                ForEach(ScrollViewLazyContainersLessons.all) { lesson in
                    CodePreviewContainer(title: lesson.title,
                                         code: lesson.code,
                                         resultView: lesson.result?())
                }
            }
        }
    }
}
