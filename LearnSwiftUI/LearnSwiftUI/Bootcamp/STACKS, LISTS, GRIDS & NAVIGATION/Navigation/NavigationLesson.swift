//
//  NavigationLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/1/26.
//

import SwiftUI

struct NavigationLesson {
    static let all = [Lesson(title: "Navigation & One-way Data Flow", code: """
    App State
       ↓
    NavigationPath
       ↓
    NavigationStack
       ↓
    Screen
📌 NavigationPath chính là source of truth
""", result: nil),
                      Lesson(title: "NavigationStack in SwiftUI", code: """
NavigationStack is a view container introduced in iOS 16, replacing the older NavigationView. 
It provides a more modern and powerful way to manage navigation within SwiftUI.

Basic Usage:

NavigationStack {
    List {
        NavigationLink("Details Page") {
            DetailView()
        }
    }
    .navigationTitle("Homepage")
}

""", result: nil), // NavigationStackExample()
                      
                      Lesson(title: "NavigationPath — The Heart of Navigation", code: """
What is NavigationPath?

    @State private var path = NavigationPath()

NavigationPath = a state array that describes the stack
Each element = 1 screen
NavigationStack allows you to manage the navigation stack programmatically via paths:

struct NavigationPathExample: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Goto Page 1") {
                    path.append("page1")
                }
                
                Button("Goto Page 2") {
                    path.append("page2")
                }
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "page1":
                    Page1Example(path: $path)
                case "page2":
                    Page2Example(path: $path)
                default:
                    EmptyView()
                }
            }
            .navigationTitle("NavigationPathExample")
        }
    }
}

""", result: nil), // NavigationPathExample()
                      Lesson(title: "How to push, pop, popToRoot", code: """
Example:

Push:
    path.append(item)

Pop:
    path.removeLast()

Pop to root:
    path.removeLast(path.count)

struct Page1Example: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 24.0) {
            Button("push to Page 2") {
                path.append("page2")
            }
            
            Button("pop") {
                path.removeLast()
            }
            
            Button("pop to root") {
                path.removeLast(path.count)
            }
        }
        .navigationDestination(for: String.self) { value in
            if value == "page2" {
                Page2Example(path: $path)
            }
        }
        .navigationTitle("Page 1")
    }
}
""", result: nil),
                      Lesson(title: "Enum Route — STANDARD ARCHITECTURE", code: """
🔑 Should do this

    enum Route: Hashable { 
        case home 
        case details(Item) 
        case settings
    }
    .navigationDestination(for: Route.self) { route in 
        switch route { 
            case .home: 
                HomeView() 
            case .detail(let item): 
                DetailView(item: item) 
            case .settings: 
                SettingsView() 
        }
    }

📌 Strongly-typed navigation
📌 Not string-based
""", result: nil),
                      Lesson(title: "Deep Linking (EXTREMELY IMPORTANT)", code: """
🧠 Idea
Deep link = initializes NavigationPath

    path.append(.home)
    ath.append(.detail(item))

➡️ App opens on the correct screen
➡️ No need for manual pushing
""", result: nil),
                      Lesson(title: "COMMON PERFORMANCE TRAPS & BUGS ⚠️", code: """
❌ Trap 1 — Nested NavigationStacks
➡️ Confusing State, Incorrect Backspace

❌ Trap 2 — Self-Push Views
➡️ Coupling + Difficult to Test

❌ Trap 3 — NavigationLink + onTapGesture
➡️ Unpredictable Behavior
""", result: nil),
                      Lesson(title: "Full demo NavigationManager", code: """
For a complete demo of the NavigationManager class,
 please refer to the NavigationManagerBootcamp struct in our project.
""", result: nil)
    ]
}
