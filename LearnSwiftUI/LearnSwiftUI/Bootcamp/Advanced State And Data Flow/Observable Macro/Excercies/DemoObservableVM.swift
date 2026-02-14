//
//  DemoObservableVM.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/2/26.
//

import Observation
import SwiftUI

struct TaskStore: Identifiable {
    var id = UUID()
    let title: String
    var isCompleted: Bool = false
    let createdAt = Date()
}

enum TaskStoreFilter: CaseIterable {
    case all, complete, incomplete
    
    var title: String {
        switch self {
        case .complete: "Complete"
        case .incomplete: "Incomplete"
        case .all: "All"
        }
    }
}

@Observable
class DemoObservableVM {
    private var taskStore: [TaskStore] = []
    var taskStoreFilter: TaskStoreFilter = .all
    var taskStoreFiltered: [TaskStore] {
        switch taskStoreFilter {
        case .complete:
            taskStore.filter { $0.isCompleted }
        case .incomplete:
            taskStore.filter { !$0.isCompleted }
        case .all:
            taskStore
        }
    }
    
    func addTask(_ nameOfTask: String) {
        taskStore.append(TaskStore(title: nameOfTask))
    }
    
    func removeTask(_ taskId: UUID) {
        taskStore.removeAll(where: {$0.id == taskId })
    }
    
    func toggleTask(_ taskId: UUID) {
        if let taskIndex = taskStore.firstIndex(where: { $0.id == taskId }) {
            taskStore[taskIndex].isCompleted.toggle()
        }
    }
}

struct TaskStoreView: View {
    @State private var vm = DemoObservableVM()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TaskStoreFilterView(vm: vm)
                TaskStoreInputView(vm: vm)
                TaskStoreList(vm: vm)
            }
            .customNavigationTitle("Observable Macro Demo")
        }
    }
}

struct TaskStorDetailView: View {
    @Bindable var vm: DemoObservableVM
    let taskId: UUID
        
    private var task: TaskStore {
        vm.taskStoreFiltered.first(where: { $0.id == taskId }) ?? TaskStore(title: "Task not found")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                Text("Status")
                    .fontWeight(.medium)
                Text(task.isCompleted ? "Done" : "Not done")
                    .foregroundStyle(task.isCompleted ? .green : .orange)
            }
            
            HStack {
                Text("Create date:")
                    .fontWeight(.medium)
                Text(task.createdAt, style: .date)
            }
            
            Button {
                vm.toggleTask(task.id)
            } label: {
                Text(task.isCompleted ? "Unmark as complete" : "Mark as complete")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TaskStoreView()
}

struct TaskStoreFilterView: View {
    @Bindable var vm: DemoObservableVM
    var body: some View {
        Section {
            Picker("Filter", selection: $vm.taskStoreFilter) {
                ForEach(TaskStoreFilter.allCases, id: \.self) { filter in
                    Text(filter.title)
                }
            }
            .pickerStyle(.palette)
        }
    }
}

struct TaskStoreInputView: View {
    @Bindable var vm: DemoObservableVM
    @State private var newTask = ""
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                TextField("Input new task", text: $newTask)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: StrokeStyle(lineWidth: 2.0))
                        
                    }
                Button("Add task") {
                    vm.addTask(newTask)
                    newTask = ""
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

struct TaskStoreList: View {
    @Bindable var vm: DemoObservableVM
    var body: some View {
        Section("Tasks") {
            LazyVStack(alignment: .leading) {
                ForEach(vm.taskStoreFiltered, id: \.id) { task in
                    NavigationLink {
                        TaskStorDetailView(vm: vm, taskId: task.id)
                    } label: {
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle": "circle")
                            Text(task.title)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}
