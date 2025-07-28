//
//  ObservableObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/7/25.
//

import Foundation
import SwiftUI

struct Task: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var subtitle: String
    var isCompleted: Bool
}

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task]
    
    init() {
        self.tasks = []
    }
    
    func addTask(title: String, subtitle: String) {
        let newTask = Task(title: title, subtitle: subtitle, isCompleted: false)
        tasks.append(newTask)
    }
    
    func deleteTask(for task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
        }
    }
    
    func toggleCompletion(for task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func loadTasks() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            self.tasks = [
                .init(title: "Buy milk", subtitle: "From the dairy section", isCompleted: false),
                .init(title: "Go for a walk", subtitle: "After dinner", isCompleted: true),
                .init(title: "Read a book", subtitle: "While sipping coffee", isCompleted: false),
            ]
        }
    }
}


#Preview {
    TaskHStackView(task: Task(title: "Title", subtitle: "Subtitle", isCompleted: true), isCompleted: {})
}

struct TaskHStackView: View {
    var task: Task
    var isCompleted: (() -> Void)?
    var delete: (() -> Void)?
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding([.leading, .top], 15)
                Text(task.subtitle)
                    .padding([.leading, .bottom], 15)
            }
            Spacer()
            
            Button {
                delete?()
            } label: {
                Text("Delete")
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.red)
                    )
            }

            RoundedRectangle(cornerRadius: 10).fill(Color.white)
                .frame(width: 30, height: 30)
                .overlay {
                    Image(systemName: task.isCompleted ? "checkmark" : "")
                }
                .padding(.trailing, 20)
                .onTapGesture {
                    isCompleted?()
                }
                
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(RoundedRectangle(cornerRadius: 8).fill(task.isCompleted ? Color.green : Color.gray))
        .padding()
    }
}

#Preview {
    AddTaskView(onAdd: nil)
}

struct AddTaskView: View {
    @State private var task: Task
    var onAdd: ((Task) -> Void)?
    
    init(onAdd: ((Task) -> Void)?) {
        self.task = Task(title: "", subtitle: "", isCompleted: false)
        self.onAdd = onAdd
    }
    
    var body: some View {
        VStack {
            Text("Add Task")
                .font(.headline)
            TextField("Enter title...", text: $task.title)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
            
            TextField("Enter subtitle...", text: $task.subtitle)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
            
            Spacer().frame(height: 20)
            
            Button(action: {
                onAdd?(task)
                task.title = ""
                task.subtitle = ""
            }) {
                Text("Add Task")
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill( (task.title != "" && task.subtitle != "") ? Color.green : Color.green.opacity(0.5) )
                    )
            }.disabled(task.title == "" || task.subtitle == "")
        }
        .padding(20)
    }
}

struct TaskList: View {
    @ObservedObject private var viewModel = TaskListViewModel()
    
    var body: some View {
        VStack {
            AddTaskView { task in
                viewModel.addTask(title: task.title, subtitle: task.subtitle)
            }
            
            ScrollView() {
                ForEach(viewModel.tasks) { task in
                    VStack(spacing: 10) {
                        TaskHStackView(task: task, isCompleted: {
                            viewModel.toggleCompletion(for: task)
                        }, delete: {
                            viewModel.deleteTask(for: task)
                        })
                    }
                }
            }
        }
        
        .onAppear {
            viewModel.loadTasks()
        }
    }
}

#Preview {
    TaskListContentView()
}

struct TaskListContentView: View {
    
    @StateObject private var viewModel = TaskListViewModel()
    
    var body: some View {
        NavigationView {
            TaskList()
                .environmentObject(viewModel)
                .navigationTitle("Todo List")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
