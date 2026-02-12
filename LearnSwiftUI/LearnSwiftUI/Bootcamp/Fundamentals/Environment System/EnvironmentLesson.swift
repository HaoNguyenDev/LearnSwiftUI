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
"""#, result: nil),
        Lesson(title: "Environment Objects vs Environment Values", code: #"""
// Environment Values - for simple values
// @Environment(\.colorScheme) var colorScheme

// Environment Objects - for complex objects

// Old syntax
class UserSettings: ObservableObject {
    @Published var fontSize: CGFloat = 16
    @Published var isDarkMode = false
}

struct RootView: View {
    @StateObject private var settings = UserSettings()
    
    var body: some View {
        ContentView()
            .environmentObject(settings)
    }
}

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        Text("Hello")
            .font(.system(size: settings.fontSize))
    }
}

// New syntax iOS 17+
@Observable
class UserSettings {
    var fontSize: CGFloat = 16
    var isDarkMode = false
}

struct RootView: View {
    @State private var settings = UserSettings()
    
    var body: some View {
        ContentView()
            .environment(settings)
    }
}

struct ContentView: View {
    @Environment(UserSettings.self) var settings
    
    var body: some View {
        Text("Hello")
            .font(.system(size: settings.fontSize))
    }
}
"""#, result: nil),
         Lesson(title: "Performance Considerations"),
        Lesson(title: "View Identity & Equatable", code: #"""
// SwiftUI uses struct equality to decide when to re-render.

struct ExpensiveView: View, Equatable {
    let data: String
    
    var body: some View {
        Text(data)
            .onAppear {
                print("ExpensiveView appeared")
            }
    }
    
    // Custom equality
    static func == (lhs: ExpensiveView, rhs: ExpensiveView) -> Bool {
        lhs.data == rhs.data
    }
}

struct ParentView: View {
    @State private var counter = 0
    
    var body: some View {
        VStack {
            // Only re-render when the data changes.
            ExpensiveView(data: "Static")
                .equatable()
            
            Button("Increment: \(counter)") {
                counter += 1
            }
        }
    }
}
"""#, result: nil),
        Lesson(title: "Avoid Heavy Computations in Body", code: #"""
// ❌ BAD - computed each time the body is called
struct BadExample: View {
    @State private var items: [Item] = []
    
    var body: some View {
        let processedItems = items.map { expensiveProcess($0) }
        
        List(processedItems) { item in
            Text(item.name)
        }
    }
}

// ✅ GOOD - Use a computed property or @State
struct GoodExample: View {
    @State private var items: [Item] = []
    
    private var processedItems: [Item] {
        items.map { expensiveProcess($0) }
    }
    
    var body: some View {
        List(processedItems) { item in
            Text(item.name)
        }
    }
}

// ✅ BETTER - results cache
struct BetterExample: View {
    @State private var items: [Item] = []
    @State private var processedItems: [Item] = []
    
    var body: some View {
        List(processedItems) { item in
            Text(item.name)
        }
        .onChange(of: items) { newItems in
            processedItems = newItems.map { expensiveProcess($0) }
        }
    }
}
"""#, result: nil),
        Lesson(title: "Modifier Performance", code: #"""
// Reusable modifiers are better than repeated code.
struct PerformanceDemo: View {
    var body: some View {
        VStack {
            // ✅ GOOD - reusable modifier
            ForEach(0..<100) { _ in
                Text("Item")
                    .cardStyle()
            }
        }
    }
}

extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
    }
}
"""#, result: nil)
    ]
}
