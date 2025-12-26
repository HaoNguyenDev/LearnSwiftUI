//
//  CodePreviewContainer.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/12/25.
//

import SwiftUI

struct CodePreviewContainer: View {
    let example: CodeExample

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(example.title)
                .font(.headline)

            CodeBlockView(code: example.code)

            Text("Result")
                .font(.subheadline)
                .foregroundColor(.secondary)

            example.resultView
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

