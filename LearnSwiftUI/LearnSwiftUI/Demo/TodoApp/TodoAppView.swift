//
//  TodoAppView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/7/25.
//

import Foundation
import SwiftUI

struct TodoAppView: View {
    @EnvironmentObject private var todoStore: TodoStore
    
    var body: some View {
        TabView {
            // Tab 1: Todo List
            NavigationView {
                TodoListView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Todo")
            }
            
            // Tab 2: Statistics
            NavigationView {
                Text("Statistics")
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Statistics")
            }
        }
        .environmentObject(todoStore)
    }
}

#Preview {
    TodoAppView()
        .environmentObject(TodoStore())
}
