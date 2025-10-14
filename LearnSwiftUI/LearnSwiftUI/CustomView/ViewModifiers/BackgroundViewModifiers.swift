//
//  BackgroundViewModifiers.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/10/25.
//

import SwiftUI

extension View {
    func setDefaultBackground() -> some View {
        modifier(BackgroundModifier())
    }
    
}
// MARK: - Modifiers
struct BackgroundModifier: ViewModifier {
    @Environment(\.theme) var theme
    func body(content: Content) -> some View {
        content
            .background(
                ContainerRelativeShape()
                    .fill(theme.color.backgroundPrimary)
                    .ignoresSafeArea(edges: .all)
            )
    }
}
