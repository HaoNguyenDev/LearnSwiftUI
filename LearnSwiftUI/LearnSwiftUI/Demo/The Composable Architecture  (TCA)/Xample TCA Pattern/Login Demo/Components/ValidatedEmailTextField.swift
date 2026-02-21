//
//  ValidatedTextField.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import SwiftUI
// ── ValidatedTextField ────────────────────────────────────────

struct ValidatedEmailTextField: View {
    let title: String
    let text: Binding<String>
    let error: String?
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var onEndEditing: (() -> Void)? = nil
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Label
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .tracking(0.8)
                .textCase(.uppercase)
                .foregroundColor(error != nil ? Color(hex: "E05252") : Color(hex: "8A8880"))
            
            // Input
            TextField("", text: text)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal, 14)
                .padding(.vertical, 13)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            error != nil ? Color(hex: "E05252") : Color(hex: "E2E0DA"),
                            lineWidth: 1
                        )
                )
            //                .onSubmit { onEndEditing?() }
                .focused($isFocused)
                .onChange(of: isFocused) { oldValue, newValue in
                    onEndEditing?()
                }
            
            // Error
            if let error {
                Label(error, systemImage: "exclamationmark.circle")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "E05252"))
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeInOut(duration: 0.18), value: error)
    }
}
