//
//  TextViewModifiers.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 12/10/25.
//

import SwiftUI

struct TitleTextStyle: ViewModifier {
    @Environment(\.theme) var theme
    var size: CGFloat = 24
    var color: Color = .primary
    
    func body(content: Content) -> some View {
        content
            .font(theme.font.bold(ofSize: size))
            .foregroundColor(color)
    }
}

extension View {
    func titleTextStyle(_ style: TitleTextStyle) -> some View {
        modifier(style)
    }
}

#Preview("Title TextStyle") {
    VStack(spacing: 30) {
        Text("Hello, World!")
            .modifier(
                TitleTextStyle(size: 30, color: .primariesSelected)
            )
        
        Text("Hello, World!")
            .titleTextStyle(.init(size: 30, color: .backgroundDark))
    }
}
