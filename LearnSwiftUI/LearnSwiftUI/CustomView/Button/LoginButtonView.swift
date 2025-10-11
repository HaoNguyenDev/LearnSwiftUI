//
//  LoginButtonView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/10/25.
//

import SwiftUI

struct LoginButtonView : View {
    @Environment(\.theme) var theme
    @Binding var isValidLogin: Bool
    @Binding var isValidPassword: Bool
    
    var onTapped: VoidResult?

    var body: some View {
        return Button("Login") {
            onTapped?()
        }
        .buttonStyle(
            HButton(size: .large, type: .primary)
        )
        .disabled(isValid == false)
        .cornerRadius(4)
        .shadow(color: isValid ? theme.color.darkGray.opacity(0.5) : .clear,
                radius: 14, x: 0, y: 9)
        .padding(.top, 36)
        .padding(.horizontal, 32)
    }
    
    private var isValid: Bool {
        return isValidLogin && isValidPassword
    }
}

#Preview {
    LoginButtonView(isValidLogin: .constant(true),
                    isValidPassword: .constant(true),
                    onTapped: {
        
    })
}
