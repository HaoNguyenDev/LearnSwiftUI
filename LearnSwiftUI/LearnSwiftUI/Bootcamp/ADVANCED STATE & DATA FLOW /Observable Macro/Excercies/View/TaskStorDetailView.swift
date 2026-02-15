//
//  TaskStorDetailView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/2/26.
//

import SwiftUI

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
            
            taskStatus
            taskCreateDate
            changeTaskStatus
            Spacer()
            
        }
        .padding()
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var taskStatus: some View {
        HStack {
            Text("Status")
                .fontWeight(.medium)
            Text(task.isCompleted ? "Done" : "Not done")
                .foregroundStyle(task.isCompleted ? .green : .orange)
        }
    }
    
    private var taskCreateDate: some View {
        HStack {
            Text("Create date:")
                .fontWeight(.medium)
            Text(task.createdAt, style: .date)
        }
    }
    
    private var changeTaskStatus: some View {
        Button {
            vm.toggleTask(task.id)
        } label: {
            Text(task.isCompleted ? "Unmark as complete" : "Mark as complete")
                .frame(maxWidth: .infinity)
        }.buttonStyle(.borderedProminent)
    }
}
