//
//  CodeBlockView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/12/25.
//

import SwiftUI

struct CodeBlockView: View {
    let code: String
    
    var body: some View {
        ScrollView(.horizontal) {
            Text(code)
                .font(.system(.caption2, design: .monospaced))
                .padding()
                .background(Color.black.opacity(0.9))
                .foregroundStyle(.yellow)
                .cornerRadius(12.0)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
}

#Preview {
    CodeBlockView(code:
"""
Text("Title")
    .font(.title)
""")
}
