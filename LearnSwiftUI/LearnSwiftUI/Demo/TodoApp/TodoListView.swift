//
//  TodoListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/7/25.
//

import Foundation
import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var todoStore: TodoStore
    @State private var newTodoTitle: String = ""
    @State private var showingAddTodo: Bool = false
    
    
    var body: some View {
        List {
            //Add new todo section
            Section {
                HStack {
                    TextField("Add new todo...", text: $newTodoTitle)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                    Button {
                        if !newTodoTitle.isEmpty {
                            todoStore.addTodo(newTodoTitle)
                            newTodoTitle = ""
                        }
                    } label: {
                        Text("Add")
                    }.buttonStyle(.borderedProminent)
                    .disabled(newTodoTitle.isEmpty)
                    
                }
            }
            
            //Filter section
            Section {
                Picker("Filter", selection: $todoStore.fillter) {
                    ForEach(TodoFilter.allCases, id: \.self) { filter in
                        Text(filter.title)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            //Todo Items
            Section {
                if todoStore.filteredTodos.isEmpty {
                    Text("No todo yet")
                        .font(.headline)
                        .bold()
                } else {
                    ForEach(todoStore.filteredTodos) { todo in
                        NavigationLink(destination: TodoDetailView(todo: todo)) {
                            TodoRowView(todo: todo)
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }
            }
            
        }
        .navigationTitle("Todo App")
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Add") {
//                    showingAddTodo = true
//                }
//            }
//        }
//        .sheet(isPresented: $showingAddTodo) {
//            Text("Add Todo view")
//        }
    }
    
    private func deleteTodo(offsets: IndexSet) {
        for index in offsets {
            let todoToDelete = todoStore.filteredTodos[index]
            todoStore.deleteTodo(todoToDelete)
        }
    }
}

#Preview {
    TodoListView()
        .environmentObject(TodoStore())
}
