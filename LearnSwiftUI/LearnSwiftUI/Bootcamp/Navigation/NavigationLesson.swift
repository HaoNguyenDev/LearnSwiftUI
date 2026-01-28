//
//  NavigationLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/1/26.
//

import SwiftUI

struct NavigationLesson {
    static let all = [Lesson(title: "NavigationStack in SwiftUI", code: """
NavigationStack is a view container introduced in iOS 16, replacing the older NavigationView. 
It provides a more modern and powerful way to manage navigation within SwiftUI.

Basic Usage:

NavigationStack {
    List {
        NavigationLink("Details Page") {
            DetailView()
        }
    }
    .navigationTitle("Homepage")
}

""", result: nil), // NavigationStackExample()
                      
                      Lesson(title: "NavigationPath — The Heart of Navigation", code: """
What is NavigationPath?

    @State private var path = NavigationPath()

NavigationPath = a state array that describes the stack
Each element = 1 screen
NavigationStack allows you to manage the navigation stack programmatically via paths:

struct NavigationPathExample: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Goto Page 1") {
                    path.append("page1")
                }
                
                Button("Goto Page 2") {
                    path.append("page2")
                }
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "page1":
                    Page1Example(path: $path)
                case "page2":
                    Page2Example(path: $path)
                default:
                    EmptyView()
                }
            }
            .navigationTitle("NavigationPathExample")
        }
    }
}

""", result: nil), // NavigationPathExample()
                      Lesson(title: "How to push, pop, popToRoot", code: """
Example:

Push:
    path.append(item)

Pop:
    path.removeLast()

Pop to root:
    path.removeLast(path.count)

struct Page1Example: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 24.0) {
            Button("push to Page 2") {
                path.append("page2")
            }
            
            Button("pop") {
                path.removeLast()
            }
            
            Button("pop to root") {
                path.removeLast(path.count)
            }
        }
        .navigationDestination(for: String.self) { value in
            if value == "page2" {
                Page2Example(path: $path)
            }
        }
        .navigationTitle("Page 1")
    }
}
""", result: nil),
                      Lesson(title: "", code: """

""", result: nil),
                      Lesson(title: "", code: """

""", result: nil),
                      Lesson(title: "", code: """

""", result: nil),
                      Lesson(title: "", code: """

""", result: nil),
                      Lesson(title: "", code: """

""", result: nil)
    ]
}
