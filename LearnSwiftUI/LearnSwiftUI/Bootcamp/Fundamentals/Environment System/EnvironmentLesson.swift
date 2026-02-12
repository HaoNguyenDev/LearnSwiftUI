//
//  EnvironmentLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/2/26.
//

import SwiftUI

struct EnvironmentLesson {
    static let all = [
        Lesson(title: "Environment Values", code:
#"""
struct EnvironmentDemo: View {
    // Read environment values from system
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.locale) var locale
    
    var body: some View {
        VStack {
            Text("Color Scheme: \(colorScheme == .dark ? "Dark" : "Light")")
            Text("Size Class: \(sizeClass == .compact ? "Compact" : "Regular")")
            Text("Locale: \(locale.identifier)")
        }
    }
}
"""#, result: {
    AnyView(ResultBlockView(content: {
        EnvironmentDemo()
    }))
}),
        Lesson(title: "Custom Environment Values", code: #"""
// 1. Define EnvironmentKey
struct ThemeKey: EnvironmentKey { 
    static let defaultValue: Theme = .light
}

// 2. Extend EnvironmentValues
extension EnvironmentValues ​​{ 
    var theme: Theme { 
        get { self[ThemeKey.self] } 
        set { self[ThemeKey.self] = newValue } 
    }
}

// 3. Extend View for convenience
extension View { 
    func theme(_ theme: Theme) -> some View { 
        environment(\.theme, theme) 
    }
}

// 4. Define Theme
enum Theme { 
    case light, dark 

    var backgroundColor: Color { 
        switch self { 
            case .light: return .white 
            case .dark: return .black 
        } 
    } 

    var textColor: Color { 
        switch self { 
            case .light: return .black 
            case .dark: return .white 
        } 
    }
}

// 5. Usage
struct ThemedView: View { 
    @Environment(\.theme) var theme 

    var body: some View { 
        Text("Themed Text") 
            .foregroundColor(theme.textColor) 
            .background(theme.backgroundColor) 
    }
}

struct ParentView: View { 
    var body: some View { 
        ThemedView() 
            .theme(.dark) 
    }
}
"""#, result: nil)
    ]
}
