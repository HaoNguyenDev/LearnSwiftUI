//
//  GeometryReaderBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24.0) {
                ForEach(GeometryReaderCoordinateSpaceLessons.all) { lesson in
                    CodePreviewContainer(title: lesson.title,
                                         code: lesson.code,
                                         resultView: lesson.result?())
                }
            }
        }
    }
}
