//
//  HButton.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/10/25.
//

import SwiftUI

struct HButton: ButtonStyle {
    @Environment(\.theme) var theme
    @Environment(\.theme.color) var color
    @Environment(\.isEnabled) var isEnabled
    
    let size: ButtonSize
    let type: ButtonType
    let customTitleHorizontalPadding: CGFloat?
    let customTitleFont: Font?
    let customTitleColor: Color?
    let customBackgroundColor: Color?
    let customSelectedBackgroundColor: Color?
    
    init(size: ButtonSize,
         type: ButtonType,
         customTitleHorizontalPadding: CGFloat? = nil,
         customTitleFont: Font? = nil,
         customTitleColor: Color? = nil,
         customBackgroundColor: Color? = nil,
         customSelectedBackgroundColor: Color? = nil) {
        self.size = size
        self.type = type
        self.customTitleHorizontalPadding = customTitleHorizontalPadding
        self.customTitleFont = customTitleFont
        self.customTitleColor = customTitleColor
        self.customBackgroundColor = customBackgroundColor
        self.customSelectedBackgroundColor = customSelectedBackgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        let titleColor = titleColor(isPressed: isPressed)
        let fillColor = fillColor(isPressed: isPressed)
        let backgroundColor = backgroundColor(isPressed: isPressed)
        
        configuration.label
            .font(titleFont)
            .foregroundColor(titleColor)
            .padding(.horizontal, customTitleHorizontalPadding ?? 10)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: maxHeight)
            .background(backgroundColor.roundCorners(8))
            .fixedSize(horizontal: size != .large, vertical: size != .large)
            .roundedBorder(
                cornerRadius: 8,
                lineWidth: strokeWeight,
                borderColor: fillColor
            )
    }
}

// MARK: - Enums
extension HButton {
    enum ButtonSize {
        case large
        case medium
        case small
    }
    
    enum ButtonType {
        case primary
        case secondary
        case tertiary
    }
}

//MARK: - Getters
extension HButton {
    var strokeWeight: CGFloat { type == .secondary ? 1 : 0 }
    var maxWidth: CGFloat? { size == .large ? .infinity : nil }
    var minHeight: CGFloat? { size == .small ? 0 : 44 }
    var maxHeight: CGFloat? { size == .large ? 56 : 44 }
    
    func backgroundColor(isPressed: Bool) -> Color {
        guard isEnabled else {
            return type == .primary ? color.neutralsButtonDisabled : .clear
        }

        if let customBackgroundColor {
            if let customSelectedBackgroundColor {
                return isPressed ? customSelectedBackgroundColor : customBackgroundColor
            }
            return customBackgroundColor
        }
        
        switch type {
        case .primary:
            return isPressed ? color.primariesSelected : color.primariesDefault
        default:
            return color.backgroundLight.opacity(0.01)
        }
    }
    
    var titleFont: Font {
        if let customTitleFont { return customTitleFont }
        return type == .primary ? theme.font.bold(ofSize: 16) : theme.font.regular(ofSize: 16)
    }
    
    func titleColor(isPressed: Bool) -> Color {
        guard isEnabled else { return color.textTertiary }
        
        if let customTitleColor { return customTitleColor }
        
        switch type {
        case .primary:
            return color.textWhite
        default:
            return isPressed ? color.primariesSelected : color.primariesDefault
        }
    }
    
    func fillColor(isPressed: Bool) -> Color {
        guard isEnabled else {
            switch type {
            case .primary:
                return color.textTertiary
            case .secondary:
                return color.neutralsButtonDisabled
            default:
                return .clear
            }
        }
        
        if let customTitleColor { return customTitleColor }
        
        switch type {
        case .primary:
            return color.textWhite
        default:
            return isPressed ? color.primariesSelected : color.primariesDefault
        }
    }
}

// MARK: - ButtonStyle
extension ButtonStyle where Self == HButton {
    static var primary: HButton {
        HButton(size: .large, type: .primary)
    }
    
    static func primary(size: HButton.ButtonSize) -> HButton {
        HButton(size: size, type: .primary)
    }
    
    static func primary(color: Color? = nil) -> HButton {
        HButton(size: .large, type: .primary, customBackgroundColor: color)
    }
    
    static var secondary: HButton {
        HButton(size: .large, type: .secondary)
    }
    
    static func secondary(color: Color? = nil) -> HButton {
        HButton(size: .large, type: .secondary, customTitleColor: color)
    }
    
    static func secondary(size: HButton.ButtonSize) -> HButton {
        HButton(size: size, type: .secondary)
    }
    
    static var tertiary: HButton {
        HButton(size: .large, type: .tertiary)
    }
    
    static func tertiary(size: HButton.ButtonSize) -> HButton {
        HButton(size: size, type: .tertiary)
    }
}

#Preview("Size=Large, Style=Primary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(.primary)
        
        Button("Continue") {}
            .buttonStyle(.primary)
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Large, Style=Secondary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(.secondary)
        
        Button("Continue") {}
            .buttonStyle(.secondary)
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Large, Style=Tertiary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(.tertiary)
        
        Button("Continue") {}
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Medium, Style=Primary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButton(size: .medium, type: .primary))
        
        Button("Continue") {}
            .buttonStyle(HButton(size: .medium, type: .primary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Medium, Style=Secondary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButton(size: .medium, type: .secondary))
        
        Button("Continue") {}
            .buttonStyle(HButton(size: .medium, type: .secondary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Medium, Style=Tertiary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButton(size: .medium, type: .tertiary))
        
        Button("Continue") {}
            .buttonStyle(HButton(size: .medium, type: .tertiary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Small, Style=Primary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButton(size: .small, type: .primary))
        
        Button("Continue") {}
            .buttonStyle(HButton(size: .small, type: .primary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Small, Style=Secondary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButton(size: .small, type: .secondary))
        
        Button("Continue") {}
            .buttonStyle(HButton(size: .small, type: .secondary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Small, Style=Tertiary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButton(size: .small, type: .tertiary))
        
        Button("Continue") {}
            .buttonStyle(HButton(size: .small, type: .tertiary))
            .disabled(true)
    }
    .padding()
}

#Preview("Custom Buttons") {
    VStack(spacing: 20) {
        Button("Login") {}
            .buttonStyle(
                HButton(
                    size: .large,
                    type: .primary,
                    customTitleColor: Color.textPrimary,
                    customBackgroundColor: Color.backgroundLight
                )
            )
        
        Button("Register") {}
            .buttonStyle(
                HButton(
                    size: .large,
                    type: .primary,
                    customTitleColor: Color.textWhite,
                    customBackgroundColor: Color.semanticsSuccessFull,
                    customSelectedBackgroundColor: Color.semanticsSuccessSelected
                )
            )
            .disabled(false)
        
        Button("Delete") {}
            .buttonStyle(
                HButton(
                    size: .large,
                    type: .primary,
                    customTitleColor: Color.textWhite,
                    customBackgroundColor: Color.semanticsErrorFull,
                    customSelectedBackgroundColor: Color.semanticsErrorSelected
                )
            )
            .disabled(false)
    }
    .padding()
}
