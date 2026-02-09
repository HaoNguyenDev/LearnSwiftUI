//
//  ModifierPatterns.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/2/26.
//

import SwiftUI

struct ModifierPatterns: View {
    var body: some View {
        VStack(spacing: 20) {
            // Pattern 1: Card style
            Text("Card Content")
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 5)
            
            // Pattern 2: Button style
            Text("Button")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 5)
            
            // Pattern 3: Input field
            Text("Input")
                .padding()
                .background(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue,style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [10]))
                )
        }
    }
}

#Preview {
    ModifierPatterns()
}
