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
    let keyboardType: UIKeyboardType
    let leftImage: Image?
    @Binding var text: String
    @Binding var errorMessage: String?
    var onTap: VoidResult? = nil
    
    init(title: String?,
         placeholder: String,
         keyboardType: UIKeyboardType = .default,
         leftImage: Image? = nil,
         text: Binding<String>,
         errorMessage: Binding<String?> = .constant(nil),
         onTap: VoidResult? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.leftImage = leftImage
        self._text = text
        self._errorMessage = errorMessage
        self.onTap = onTap
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleText()
            textField()
            errorText()
                .padding(.top, 4)
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
            leftImageView()
            ZStack(alignment: .leading) {
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
                    .keyboardType(keyboardType)
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
        if let leftImage {
            leftImage
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(theme.color.textPrimary)
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
    @State var phoneNumber: String = "0977 123 456"
    @State var email: String = "example@example.com"
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                HTextField(title: "Default",
                           placeholder: "Enter your text",
                           leftImage: nil,
                           text: $text)
                
                HTextField(title: "Error",
                           placeholder: "Enter your text",
                           leftImage: nil,
                           text: $text,
                           errorMessage: .constant("Error message appears here"))
                
                HTextField(title: "Phone Field",
                           placeholder: "Enter your phone number",
                           keyboardType: .phonePad,
                           leftImage: R.image.ic_help_phone.image,
                           text: $phoneNumber,
                           errorMessage: .constant(nil))
                
                
                HTextField(title: "Email Field",
                           placeholder: "Enter your phone number",
                           keyboardType: .emailAddress,
                           leftImage: R.image.ic_help_email.image,
                           text: $email,
                           errorMessage: .constant(nil))
                
                HTextField(title: "Disable Field",
                           placeholder: "Enter something...",
                           keyboardType: .default,
                           text: .constant(""),
                           errorMessage: .constant(nil))
                .disabled(true)
            }
        }
        .padding()
    }
}

#Preview {
    HTextField_Previews()
}
