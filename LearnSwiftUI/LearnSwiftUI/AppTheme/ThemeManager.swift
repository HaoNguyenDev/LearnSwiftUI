//
//  ThemeManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/8/25.
//

import SwiftUI

struct ThemeManager {
    static let light = AppTheme(primaryColor: .blue,
                                secondaryColor: .gray,
                                backgroundColor: .white,
                                textColor: .black,
                                font: .body)
    
    static let dark = AppTheme(primaryColor: .orange,
                               secondaryColor: .gray,
                               backgroundColor: .black,
                               textColor: .white,
                               font: .body)
    
    static let unicorn = AppTheme(primaryColor: .purple,
                                  secondaryColor: .pink,
                                  backgroundColor: .white,
                                  textColor: .purple,
                                  font: .title2)
}

//Step 1: Define the new environment key
struct ThemeKey: EnvironmentKey {
    static let defaultValue = ThemeManager.unicorn
}

//Step 2: Extend EnvironmentValues
extension EnvironmentValues {
    var theme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

@Observable
class ThemeViewModel {
    var currentTheme = ThemeManager.light
    
    func setTheme(_ theme: AppTheme) {
        self.currentTheme = theme
    }
}

struct ThemedTextView : View {
    @Environment(\.theme) var theme
    
    var body: some View {
        Text("Hello, World!")
            .foregroundColor(theme.textColor)
            .font(theme.font)
    }
}

#Preview {
    ThemedTextView()
        .preferredColorScheme(.dark)
}
