//
//  ListBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 28/8/25.
//

import SwiftUI

struct TaskModel: Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var isDone: Bool = false
    var isPinned: Bool = false
}

@Observable class TaskViewModel: ObservableObject {
    var tasks: [TaskModel] = [TaskModel(name: "Task 1"), TaskModel(name: "Task 2"), TaskModel(name: "Task 3")]
    
    func addTask(name: String) {
        tasks.append(TaskModel(name: name))
    }
    
    func removeTask(_ task: TaskModel) {
        if let indexOfTask = tasks.firstIndex(of: task) {
            tasks.remove(at: indexOfTask)
        }
    }
    
    func removeTask(at offSet: IndexSet) {
        tasks.remove(atOffsets: offSet)
    }
    
    func moveTask(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func toggleDoneTask(_ task: TaskModel) {
        if let indexOfTask = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[indexOfTask].isDone.toggle()
        }
    }
    
    func toggleIsPinnedTask(_ task: TaskModel) {
        if let indexOfTask = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[indexOfTask].isPinned.toggle()
        }
    }
    
}
struct ListBootcamp: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var vm = TaskViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.tasks.sorted { $0.isPinned && !$1.isPinned }) { task in
                    HStack {
                        Image(systemName: task.isDone ? "checkmark.circle" : "circle")
                            .foregroundColor(.green)
                            .onTapGesture {
                                vm.toggleDoneTask(task)
                            }
                        
                        Text(task.name)
                            .strikethrough(task.isDone,
                                           color: colorScheme == .dark ? .white : .black)
                        Spacer()
                        Image(systemName: task.isPinned ? "pin" : "")
                            .foregroundStyle(Color.yellow)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            vm.removeTask(task)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button {
                            vm.toggleIsPinnedTask(task)
                        } label: {
                            Label(task.isPinned ? "Unpin" : "Pin",
                                  systemImage: task.isPinned ? "pin.slash" : "pin")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            vm.toggleDoneTask(task)
                        } label: {
                            Label(task.isDone ? "Uncomplete" : "Complete",
                                  systemImage: task.isDone ? "arrow.uturn.backward.circle" : "checkmark.circle.fill")
                        }
                        .tint(task.isDone ? .gray : .green)
                    }
                }
                .onDelete(perform: deleteTask)
                .onMove(perform: moveTask)
            }
            .navigationBarTitle("List Bootcamp")
            .toolbar { EditButton() }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        vm.removeTask(at: offsets)
    }
    
    func moveTask(from: IndexSet, to: Int) {
        vm.moveTask(from: from, to: to)
    }
}

#Preview {
    ListBootcamp()
}
