//
//  ThemeModifier.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import SwiftUI

struct ThemeModifier: ViewModifier {
    @State var themeManager: ThemeManager
    
    func body(content: Content) -> some View {
        content
            .environment(\.theme, themeManager.activeTheme)
    }
}

extension View {
    func environmentTheme(manager: ThemeManager) -> some View {
        self.modifier(ThemeModifier(themeManager: manager))
    }
}
