//
//  ThemeModifier.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//


import Foundation
import SwiftUI

struct ThemeModifier: ViewModifier {
    @ObservedObject var themeManager = ThemeManager.shared
    
    func body(content: Content) -> some View {
        content.environment(\.theme, themeManager.activeTheme)
    }
}

extension View {
    func themed() -> some View {
        modifier(ThemeModifier())
    }
}
