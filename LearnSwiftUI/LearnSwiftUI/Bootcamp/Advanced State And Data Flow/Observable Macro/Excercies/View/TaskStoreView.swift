//
//  TaskStoreView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/2/26.
//

import SwiftUI

struct TaskStoreView: View {
    @State private var vm = DemoObservableVM()
    @State private var newTask = ""
    var onRoute: SingleResult<Route.TaskStoreViewRoute>?
    var body: some View {
        ScrollView {
            taskStoreFilterView
            taskStoreInputView
            taskStoreList
        }
    }
    
    private var taskStoreFilterView: some View {
        Section {
            Picker("Filter", selection: $vm.taskStoreFilter) {
                ForEach(TaskStoreFilter.allCases, id: \.self) { filter in
                    Text(filter.title)
                }
            }
            .pickerStyle(.palette)
        }
    }
    
    private var taskStoreInputView: some View {
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
    
    private var taskStoreList: some View {
        Section("Tasks") {
            LazyVStack(alignment: .leading) {
                ForEach(vm.taskStoreFiltered, id: \.id) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle": "circle")
                        Text(task.title)
                    }.onTapGesture {
                        onRoute?(Route.TaskStoreViewRoute.taskDetail(vm: vm, taskId: task.id))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

extension Route {
    enum TaskStoreViewRoute: Routable {
        case taskDetail(vm: DemoObservableVM,taskId: UUID)
        var id: String { "\(UUID())" }
        static func == (lhs: Route.TaskStoreViewRoute, rhs: Route.TaskStoreViewRoute) -> Bool {
            lhs.id == rhs.id
        }
    }
}

struct TaskStoreViewCoordinator: View, ScreenCoordinator {
    typealias ScreenRoute = Route.TaskStoreViewRoute
    var navRoute: any NavRouterProtocol
    
    init(navRoute: any NavRouterProtocol) {
        self.navRoute = navRoute
    }
    
    var body: some View {
        taskStoreView
            .customNavigationTitle("Demo Observable Macro VM")
            .defaultNavBackButton {
                navRoute.pop(animate: true)
            }
    }
    
    private var taskStoreView: some View {
        TaskStoreView(onRoute: { route in
            navRoute.push(route, animate: true)
        })
        .navigationDestination(for: ScreenRoute.self) { route in
            viewForRoute(route: route)
        }
    }
}

extension TaskStoreViewCoordinator {
    func viewForRoute(route: Route.TaskStoreViewRoute) -> some View {
        switch route {
        case .taskDetail(let vm, let taskID):
            TaskStorDetailView(vm: vm, taskId: taskID)
        }
    }
}

//#Preview {
//    TaskStoreView()
//}
