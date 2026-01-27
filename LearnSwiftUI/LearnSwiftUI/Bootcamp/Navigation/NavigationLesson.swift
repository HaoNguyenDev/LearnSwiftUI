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
                      
                      Lesson(title: "Manage navigation paths", code: """
NavigationStack allows you to manage the navigation stack programmatically via paths:

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Go to page 1") {
                    path.append("Page1")
                }
                Button("Go to page 2") {
                    path.append("Page2")
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "Page1" {
                    Page1View(path: $path)
                } else if value == "Page2" {
                    Page2View()
                }
            }
            .navigationTitle("Home")
        }
    }
}

""", result: nil), // NavigationPathExample()
                      Lesson(title: "", code: """

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
