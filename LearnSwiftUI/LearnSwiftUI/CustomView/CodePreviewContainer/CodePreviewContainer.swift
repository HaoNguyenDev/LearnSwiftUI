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
         code: String?,
         resultView: AnyView?) {
        self.example = CodeExample(title: title,
                                   code: code,
                                   resultView: resultView)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleView
            codeBlockView
            resultView
        }
        .padding(8)
    }
    
    @ViewBuilder
    private var titleView: some View {
        if !example.title.isEmpty {
            Text(example.title)
                .font(.headline)
        }
    }
    
    @ViewBuilder
    private var codeBlockView: some View {
        if let code = example.code {
            CodeBlockView(code: code)
        }
    }
    
    @ViewBuilder
    private var resultView: some View {
        if let resultView = example.resultView {
            VStack(alignment: .leading) {
                Text("Result UI")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                resultView
                    .frame(maxWidth: .infinity)
            }
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
