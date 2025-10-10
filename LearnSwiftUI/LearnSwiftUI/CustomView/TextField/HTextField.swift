//
//  HTextField.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import SwiftUI

struct HTextField: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(\.isEnabled) var isEnabled
    @FocusState private var isFocused
    
    let title: String?
    let placeholder: String
    let leftIcon: Image?
    @Binding var text: String
    @Binding var errorMessage: String?
    var onTap: VoidResult? = nil
    
    init(title: String?,
         placeholder: String,
         leftIcon: Image?,
         text: Binding<String>,
         errorMessage: Binding<String?> = .constant(nil),
         onTap: VoidResult? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.leftIcon = leftIcon
        self._text = text
        self._errorMessage = errorMessage
        self.onTap = onTap
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleText()
            textField()
        }
        .onTapGesture {
            isFocused = true
            onTap?()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

fileprivate extension HTextField {
    
    @ViewBuilder
    private func titleText() -> some View {
        if let title = title {
            Text(title)
                .font(theme.font.regular(ofSize: 14))
                .foregroundColor(foregroundColor)
                .padding(.bottom, 8)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func textField() -> some View {
        HStack(alignment: .center, spacing: 8) {
            ZStack(alignment: .leading) {
                leftIcon
                    .foregroundColor(theme.color.textPrimary)
                if text.isEmpty {
                    Text(placeholder)
                        .font(theme.font.regular(ofSize: 14))
                        .foregroundStyle(theme.color.textTertiary)
                        .multilineTextAlignment(.leading)
                }
                
                TextField("", text: $text)
                    .foregroundColor(isEnabled ? theme.color.textPrimary : theme.color.textDisabled)
                    .focused($isFocused)
                    .font(theme.font.regular(ofSize: 14))
                    .frame(maxHeight: isFocused || !text.isEmpty ? .infinity : 0)
                    .tint(theme.color.primariesDefault)
            }
            
            clearTextButton()
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .leading)
        .background(theme.color.backgroundLight)
        .roundedBorder(cornerRadius: 8, lineWidth: 1, borderColor: borderColor)
        .roundCorners(8)
    }
    
    @ViewBuilder
    func errorText() -> some View {
        if let errorMessage {
            Text(errorMessage)
                .font(theme.font.regular(ofSize: 14))
                .foregroundStyle(theme.color.semanticsErrorFull)
        }
    }
    
    @ViewBuilder
    func leftImageView() -> some View {
        if let leftIcon {
            leftIcon
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
        }
    }
    
    @ViewBuilder
    func clearTextButton() -> some View {
        if !text.isEmpty {
            Button(action: {
                text = ""
                isFocused = false
            }) {
                R.image.ic_close.image
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(theme.color.textPrimary)
                    .padding(8)
            }
        }
    }
}

fileprivate extension HTextField {
    var borderColor: Color {
        guard errorMessage == nil else { return theme.color.semanticsErrorFull }
        return isFocused
        ? theme.color.primariesDefault
        : theme.color.neutralsBorderDivider
    }
    
    var foregroundColor: Color {
        if !isEnabled { return theme.color.textDisabled }
        return isFocused ? theme.color.primariesDefault : theme.color.textTertiary
    }
}

struct HTextField_Previews : View {
    @State var text: String = ""
    
    var body: some View {
        ScrollView {
            Group {
                HTextField(title: "Title",
                           placeholder: "Enter your text",
                           leftIcon: nil,
                           text: $text)
            }
        }
        .padding()
    }
}

#Preview {
    HTextField_Previews()
}
