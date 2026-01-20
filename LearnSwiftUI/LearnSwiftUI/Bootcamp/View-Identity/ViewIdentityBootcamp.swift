//
//  ViewIdentityBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/1/26.
//

import SwiftUI

struct ViewIdentityBootcamp: View {
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(ViewIdentityLessons.all, id: \.id) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
        }
    }
}
