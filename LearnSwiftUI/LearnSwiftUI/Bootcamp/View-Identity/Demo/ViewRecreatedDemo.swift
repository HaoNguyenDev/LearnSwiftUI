//
//  ViewRecreatedDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/1/26.
//

import SwiftUI

struct ViewRecreatedDemo: View {
    @State private var toggle = false

    var body: some View {
        ScrollView {
            VStack {
                Toggle("Toggle", isOn: $toggle)
                
                if toggle {
                    ChildViewDemo(label: "A")
                } else {
                    ChildViewDemo(label: "B")
                }
            }
            .padding(.horizontal)
            
            CodePreviewContainer(title: "", code: """
import SwiftUI

struct ViewRecreatedDemo: View {
    @State private var toggle = false

    var body: some View {
        VStack {
            Toggle("Toggle", isOn: $toggle)

            if toggle {
                ChildViewDemo(label: "A")
            } else {
                ChildViewDemo(label: "B")
            }
        }
        .padding()
    }
}

struct ChildViewDemo: View {
    @State private var count = 0
    let label: String

    init(label: String) {
        self.label = label
        print("🚨 ChildView INIT:", label)
    }

    var body: some View {
        VStack {
            Text("Child (label)")
                .padding()
            Button("Count: (count)") {
                count += 1
            }
            .buttonStyle(.bordered)
        }
    }
}

👀 Observation
    Each time toggle → INIT runs again
    count resets to 0
📌 Conclusion
    if/else = change identity branch
    SwiftUI: “This is a different view”
""", resultView: nil)
        }
    }
}

struct ChildViewDemo: View {
    @State private var count = 0
    let label: String

    init(label: String) {
        self.label = label
        print("🚨 ChildView INIT:", label)
    }

    var body: some View {
        VStack {
            Text("Child \(label)")
                .padding()
            Button("Count: \(count)") {
                count += 1
            }
            .buttonStyle(.bordered)
        }
    }
}
