//
//  TextViewModifiers.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 12/10/25.
//

import SwiftUI

struct TextStylingModifier: ViewModifier {
    
    var font: Font?
    var size: CGFloat = 16
    var color: Color = .primary
    var textAlignment: TextAlignment = .leading
    var alignment: Alignment = .center
    
    func body(content: Content) -> some View {
        content
            .font(font ?? .system(size: size))
            .multilineTextAlignment(textAlignment)
            .frame(maxWidth: .infinity, alignment: alignment)
            .foregroundColor(color)
            .padding()
    }
}

// Combine view modifier with extension of view for quick call
extension View {
    func textStyle(font: Font? = nil,
                        size: CGFloat = 16,
                        color: Color = .primary,
                        textAlignment: TextAlignment = .center,
                        alignment: Alignment = .center) -> some View {
        modifier(TextStylingModifier(font: font,
                           size: size,
                           color: color,
                           textAlignment: textAlignment,
                           alignment: alignment))
    }
}

#Preview("Title TextStyle") {
    @Previewable @Environment(\.theme) var theme
    
    VStack(spacing: 30) {
        Text("Hello, World!")
            .modifier(
                TextStylingModifier(font: theme.font.bold(ofSize: 34),
                          color: .backgroundDark,
                          textAlignment: .leading,
                          alignment: .leading)
            )
        
        Text("Hello, World!")
            .textStyle(font: theme.font.bold(ofSize: 24),
                            color: .primariesSelected,
                            textAlignment: .center,
                            alignment: .center)
        
        Text("Hello, World!")
            .textStyle(font: theme.font.bold(ofSize: 14),
                            color: .blueText,
                            textAlignment: .trailing,
                            alignment: .trailing)
        
        Text("Hello, World!")
            .textStyle(font: .system(size: 20))
        
        Text("Hello, World!")
            .textStyle()
    }
}
