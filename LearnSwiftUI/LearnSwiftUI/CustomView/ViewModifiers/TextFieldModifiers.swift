//
//  TextFieldModifiers.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/10/25.
//

import SwiftUI

// MARK: - TextField View Modifier
struct DefaultTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .frame(height: 50)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal, 16)
    }
}

// MARK: - TextField Extension
extension View {
    func defaultTf() -> some View {
        modifier(DefaultTextFieldModifier())
    }
}

