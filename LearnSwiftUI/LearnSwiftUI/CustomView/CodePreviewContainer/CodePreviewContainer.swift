//
//  CodePreviewContainer.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/12/25.
//

import SwiftUI

struct CodePreviewContainer: View {
    let example: CodeExample

    init(title: String,
         code: String,
         resultView: AnyView?) {
        self.example = CodeExample(title: title,
                                   code: code,
                                   resultView: resultView)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(example.title)
                .font(.headline)

            CodeBlockView(code: example.code)

            resultView()
        }
        .padding(8)
    }
    
    @ViewBuilder
    private func resultView() -> some View {
        if example.resultView != nil {
            VStack(alignment: .leading) {
                Text("Result UI")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                example.resultView
                    .frame(maxWidth: .infinity)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    //MARK: - Gradient text
    CodePreviewContainer(title: "Gradient text",
                         code:
"""
Text("Gradient")
    .foregroundStyle(.linearGradient(
        colors: [.red, .orange, .blue],
        startPoint: .leading,
        endPoint: .trailing))
""", resultView: AnyView(ResultBlockView(content: {
        Text("Gradient")
            .foregroundStyle(.linearGradient(
                colors: [.red, .orange, .blue],
                startPoint: .leading,
                endPoint: .trailing
            ))
    })))
}
