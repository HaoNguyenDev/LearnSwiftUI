//
//  LazyViewLoading.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/2/26.
//

import SwiftUI

// ❌ BAD: All views created upfront
struct BadTabView: View {
    var body: some View {
        TabView {
            ExpensiveView(text: "Tab 1")  // Created immediately
                .tabItem { Label("Tab 1", systemImage: "1.circle") }
            
            ExpensiveView(text: "Tab 2")  // Created immediately
                .tabItem { Label("Tab 2", systemImage: "2.circle") }
            
            ExpensiveView(text: "Tab 3")  // Created immediately
                .tabItem { Label("Tab 3", systemImage: "3.circle") }
        }
    }
}

// ✅ GOOD: Lazy loading
struct GoodTabView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Group {
                switch selection {
                case 0: ExpensiveView(text: "Tab 1")
                case 1: ExpensiveView(text: "Tab 2")
                case 2: ExpensiveView(text: "Tab 3")
                default: EmptyView()
                }
            }
            .tabItem { Label("Tab \(selection + 1)", systemImage: "\(selection + 1).circle") }
        }
    }
}

// Alternative: LazyView wrapper
struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}

struct ExpensiveView: View {
    let text: String
    var body: some View {
        Text(text)
    }
}

struct TabViewWithLazyView: View {
    var body: some View {
        TabView {
            LazyView(ExpensiveView(text: "Tab 1"))
                .tabItem {
                    Label("Tab 1", systemImage: "1.circle")
                }
            LazyView(ExpensiveView(text: "Tab 2"))
                .tabItem {
                    Label("Tab 2", systemImage: "2.circle")
                }
            LazyView(ExpensiveView(text: "Tab 3"))
                .tabItem {
                    Label("Tab 3", systemImage: "3.circle")
                }
        }
    }
}
/*
// Usage:
TabView {
    LazyView(ExpensiveView1())  // Only created when tab shown
        .tabItem { Label("Tab 1", systemImage: "1.circle") }
}
*/

#Preview {
    TabViewWithLazyView()
}
