//
//  EnvironmentEnvironmentObjectLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/2/26.
//

import SwiftUI

struct EnvironmentEnvironmentObjectLesson {
    static let all = [
        Lesson(title: "Environment"),
        Lesson(title: "1️⃣ What is Environment?", code: """
🔎 Standard Definition
In SwiftUI, Environment is an implicit dependency injection (implicit DI) system
 that allows data to be passed from the ancestor view to the entire subtree without passing it through an initializer.

It works based on:
EnvironmentValues ​​(struct containing all key-value pairs)
EnvironmentKey (defines a custom key)
@Environment (property wrapper to read the value)
.environment() modifier (writes the value)
.environmentObject() (injects ObservableObject)
""", result: nil),
    Lesson(title: "", code: #"""
🧠 Mental Model (Important)
SwiftUI has:

View Tree
    ↓
Environment Tree (parallel)

Each view has a copy of EnvironmentValues ​​at render time.

When you set:
.environment(\.colorScheme, .dark)

SwiftUI will:
    Clone EnvironmentValues
    Override the corresponding key
    Pass it down to the subtree
👉 Environment is value-based propagation (not reference-based).
"""#, result: nil),
    Lesson(title: "2️⃣ @Environment", code: #"""
🔹 Used to read system values
Common examples:
    colorScheme
    locale
    horizontalSizeClass
    dismiss
    scenePhase
    dynamicTypeSize

📌 Basic example:
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
    Lesson(title: "⚠️ Important Note"),
    Lesson(title: "", code: """
1️⃣ The environment can only be read after the view is mounted.
Do not use in init:

init() {
    // ❌ crash if reading environment here
}

2️⃣ Environment will not trigger an update if the value does not change.
SwiftUI will re-render the view if the environment value changes.
For example: changing to dark mode → all views reading colorScheme will re-render.

3️⃣ Custom EnvironmentKey (Very important for Seniors)
🔥 When to use it?
    Global configuration
    Theme system
    App-level settings
    Inject lightweight services (not observable)

""", result: nil),
        Lesson(title: "📌 Create EnvironmentKey"),
    Lesson(title: "", code: #"""
Step 1: Define Key
private struct MyThemeKey: EnvironmentKey {
    static let defaultValue: String = "Default Theme"
}

Step 2: Extend EnvironmentValues
extension EnvironmentValues {
    var myTheme: String {
        get { self[MyThemeKey.self] }
        set { self[MyThemeKey.self] = newValue }
    }
}

Step 3: Inject
.environment(\.myTheme, "Dark Pro")

Step 4: Read
@Environment(\.myTheme) var theme
"""#, result: nil),
    Lesson(title: "Create EnvironmentKey Example", code: #"""
enum CustomTheme {
    case dark, light
    
    var textColor: Color {
        return self == .dark ? .white : .black
    }
    
    var backgroundColor: Color {
        return self == .dark ? .black : .white
    }
}

struct CustomThemeKey: EnvironmentKey {
    static let defaultValue: CustomTheme = .light
}

extension EnvironmentValues {
    var customTheme: CustomTheme {
        get { self[CustomThemeKey.self] }
        set { self[CustomThemeKey.self] = newValue }
    }
}

extension View {
    func setTheme(_ theme: CustomTheme) -> some View {
        environment(\.customTheme, theme)
    }
    
    func setDartTheme() -> some View {
        environment(\.customTheme, .dark)
    }
    
    func setLightTheme() -> some View {
        environment(\.customTheme, .light)
    }
}

struct Content: View {
    @Environment(\.customTheme) var theme
    
    var body: some View {
        Text("Hello")
            .foregroundStyle(theme.textColor)
            .background(theme.backgroundColor)
    }
}
"""#, result: nil),
    Lesson(title: "4️⃣ EnvironmentObject", code: """
🔎 Definition
@EnvironmentObject is a way to inject an ObservableObject into the entire subtree.

Unlike @Environment:

@Environment    @EnvironmentObject
Value type      Reference type
Not Observable  ObservableObject
No auto-update  Auto-update when @Published changes
""", result: nil),
    Lesson(title: "", code: """
1️⃣ Define ViewModel
class AppState: ObservableObject {
    @Published var isLoggedIn = false
}

2️⃣ Inject at root
@main
struct MyApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

3️⃣ Read read from any subview
struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Button("Logout") {
            appState.isLoggedIn = false
        }
    }
}
""", result: nil),
    Lesson(title: "⚠️ Classic Error", code: """
❌ Crash if injection is not performed
Fatal error: No ObservableObject of type AppState found
SwiftUI will crash runtime if injection is missing.
""", result: nil),
    Lesson(title: "🧠 Deep Understanding", code: """
@EnvironmentObject is:
    Runtime lookup
    Type-based matching
    No compile-time guarantee
    SwiftUI finds objects by type.
If there are 2 objects of the same type → unpredictable behavior.
""", result: nil),
    Lesson(title: "5️⃣ Environment vs EnvironmentObject vs ObservedObject", code: """
|           | Environment | EnvironmentObject | ObservedObject |
| --------- | ----------- | ----------------- | -------------- |
| Type      | Value       | Reference         | Reference      |
| Update    | Manual      | Auto              | Auto           |
| Injection | Key-based   | Type-based        | Init-based     |
| Scope     | Subtree     | Subtree           | 1 view         |
""", result: nil),
    Lesson(title: "6️⃣ When should you use which?", code: """
🟢 Use Environment when:
    Theme
    Locale
    App config
    Lightweight dependency

🟢 Use EnvironmentObject when:
    App-wide state
    Auth state
    Global router
    User session

🔴 Do not use EnvironmentObject for:
    Local state
    Child-specific data
    Single screen view model
""", result: nil),
    Lesson(title: "7️⃣ Performance Considerations", code: """
⚠️ EnvironmentObject updates can cause:
Whole subtree re-render

Example:

Root
├── ViewA
├── ViewB
├── ViewC

If AppState changes → the entire subtree re-renders.

👉 It's recommended to break down the state into smaller parts.
""", result: nil),
    Lesson(title: "8️⃣ Practical Case Studies", code: #"""
🔥 Auth Flow

if appState.isLoggedIn { 
    HomeView()
} else { 
    LoginView()
}

AppState changes → entire root swap.

🔥 Theme System
Inject custom themes:
    .environment(\.myTheme, "Corporate Blue")
Override private subtree:
    SettingsView() 
        .environment(\.myTheme, "High Contrast")
"""#, result: nil)]
}


