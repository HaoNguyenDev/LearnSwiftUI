//
//  ValidatedSecureField.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import SwiftUI
// ── ValidatedSecureField ──────────────────────────────────────

struct ValidatedSecureField: View {
    let title: String
    let text: Binding<String>
    let error: String?
    var onEndEditing: (() -> Void)? = nil
    
    @State private var isRevealed = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .tracking(0.8)
                .textCase(.uppercase)
                .foregroundColor(error != nil ? Color(hex: "E05252") : Color(hex: "8A8880"))
            
            HStack(spacing: 0) {
                Group {
                    if isRevealed {
                        TextField("", text: text)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    } else {
                        SecureField("", text: text)
                    }
                }
//                .onSubmit { onEndEditing?() }
                .focused($isFocused)
                .onChange(of: isFocused) { oldVal, newVal in
                    onEndEditing?()
                }
                Button {
                    isRevealed.toggle()
                } label: {
                    Image(systemName: isRevealed ? "eye.slash" : "eye")
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: "8A8880"))
                        .frame(width: 36, height: 36)
                }
            }
            .padding(.leading, 14)
            .padding(.trailing, 4)
            .padding(.vertical, 5)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        error != nil ? Color(hex: "E05252") : Color(hex: "E2E0DA"),
                        lineWidth: 1
                    )
            )
            
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
