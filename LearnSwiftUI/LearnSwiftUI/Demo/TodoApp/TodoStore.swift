//
//  TodoStore.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 28/7/25.
//

import Foundation
import SwiftUI

struct Todo: Identifiable {
    var id = UUID()
    let title: String
    var isCompleted: Bool = false
    let createdAt = Date()
}

enum TodoFilter: CaseIterable {
    case all, active, completed
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .active:
            return "Active"
        case .completed:
            return "Completed"
        }
    }
}

class TodoStore: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var fillter: TodoFilter = .all
    
    var filteredTodos: [Todo] {
        switch fillter {
        case .all:
            return todos
        case .active:
            return todos.filter { !$0.isCompleted }
        case .completed:
            return todos.filter { $0.isCompleted }
        }
    }
    
    func addTodo(_ title: String) {
        todos.append(Todo(title: title))
    }
    
    func deleteTodo(_ todo: Todo) {
        todos.removeAll { $0.id == todo.id }
    }
    
    func toggleTodo(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
    }
}
