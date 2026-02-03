//
//  StateManagementDeepDiveBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct StateManagementDeepDiveBootcamp: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(StateManagementDeepDiveLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
        }
    }
}
