//
//  ListBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 28/8/25.
//

import SwiftUI

struct TaskModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var isDone: Bool = false
}

@Observable class TaskViewModel: ObservableObject {
    var tasks: [TaskModel] = [TaskModel(name: "Task 1"), TaskModel(name: "Task 2"), TaskModel(name: "Task 3")]
    
    func addTask(name: String) {
        tasks.append(TaskModel(name: name))
    }
    
    func removeTask(at offSet: IndexSet) {
        tasks.remove(atOffsets: offSet)
    }
    
    func moveTask(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func toggleTask(_ task: TaskModel) {
        if let indexOfTask = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[indexOfTask].isDone.toggle()
        }
    }
    
}
struct ListBootcamp: View {
    @Environment(\.colorScheme) var colorScheme
    @State var vm = TaskViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.tasks) { task in
                    HStack {
                        Image(systemName: task.isDone ? "checkmark.circle" : "circle")
                            .foregroundColor(Color.green)
                        
                        Text(task.name)
                            .strikethrough(task.isDone, color: colorScheme == .dark ? .white : .black)
                    }
                    .onTapGesture {
                        vm.toggleTask(task)
                    }
                }
                .onDelete(perform: deleteTask)
                .onMove(perform: moveTask)
            }
            .navigationBarTitle("List Bootcamp")
            .toolbar {
                EditButton()
            }
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
