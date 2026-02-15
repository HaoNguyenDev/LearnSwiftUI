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
    private var id: UUID { UUID() }
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

extension DemoObservableVM: Hashable {
    static func == (lhs: DemoObservableVM, rhs: DemoObservableVM) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

