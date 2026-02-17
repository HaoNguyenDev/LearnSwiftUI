//
//  TodoDetailView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/7/25.
//

import Foundation
import SwiftUI

struct TodoDetailView: View {
    @EnvironmentObject var todoStore: TodoStore
    let todo: Todo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(todo.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                Text("Status")
                    .fontWeight(.medium)
                Text(todo.isCompleted ? "Done" : "Not done")
                    .foregroundStyle(todo.isCompleted ? .green : .orange)
            }
            
            HStack {
                Text("Create date:")
                    .fontWeight(.medium)
                Text(todo.createdAt, style: .date)
            }
            
            Button {
                todoStore.toggleTodo(todo)
            } label: {
                Text(todo.isCompleted ? "Unmark as complete" : "Mark as complete")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
            
            Spacer()

        }
        .padding()
        .navigationTitle("Dettail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
