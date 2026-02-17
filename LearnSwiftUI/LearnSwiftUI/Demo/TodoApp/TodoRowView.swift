//
//  TodoRowView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/7/25.
//

import Foundation
import SwiftUI

struct TodoRowView: View {
    @EnvironmentObject var todoStore: TodoStore
    let todo: Todo
    
    var body: some View {
        HStack {
            Button {
                todoStore.toggleTodo(todo)
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isCompleted ? .green : .gray)
            }.buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(todo.title)
                    .strikethrough(todo.isCompleted)
                    .foregroundColor(todo.isCompleted ? .secondary : .primary)
                
                Text(todo.createdAt, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if todo.isCompleted {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.green)
            }
        }
    }
}
