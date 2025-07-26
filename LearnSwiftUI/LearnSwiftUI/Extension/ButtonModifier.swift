//
//  Modifier.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/7/25.
//
import SwiftUI

//MARK: ViewModifier
extension View {
    public func buttonStyle(conerRadius: CGFloat,
                            foregroundColor: Color = .white,
                            padding: (Edge.Set, CGFloat)) -> some View {
        self.modifier(StrockLineModifier(conerRadius: conerRadius,
                                         foregroundColor: foregroundColor,
                                         padding: padding))
    }
}

//MARK: ViewModifier
struct StrockLineModifier: ViewModifier {
    var conerRadius: CGFloat = 10
    var foregroundColor: Color = .white
    var padding: (Edge.Set, CGFloat) = (.all, 0)
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: conerRadius)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(foregroundColor)
                    .padding(padding.0, padding.1)
            )
    }
}

//MARK: ButtonStyle
struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .background(Color.clear)
            .foregroundColor(isEnabled ? Color(hex: "#0D00FF") : .gray)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(isEnabled ?  Color(hex: "#0D00FF") : Color.gray, lineWidth: 1)
            )
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
