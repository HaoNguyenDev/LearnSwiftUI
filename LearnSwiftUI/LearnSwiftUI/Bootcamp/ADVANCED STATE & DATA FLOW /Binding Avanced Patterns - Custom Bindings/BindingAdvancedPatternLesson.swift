//
//  BindingAdvancedPatternLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 16/2/26.
//

import SwiftUI

struct BindingAdvancedPatternLesson {
    static let all = [
        Lesson(title: "What's Binding?", code: """
🔹 Definition
Binding<Value> is a reference state like wrapper to an external state source, allowing:
- Reading the value
- Writing the value
- But not owning the state

struct Binding<Value> {
    let get: () -> Value
    let set: (Value) -> Void
} 

👉 In essence, Binding is just a get/set closure.
""", result: nil),
        Lesson(title: "🔹 Quick comparison", code: """
| Property Wrapper      | Owns state?    | Role                      |
| ------------------    | -------------  | ---------------------     |
| @State                | ✅ Yes         | Source of state           |
| @StateObject          | ✅ Yes         | Source of reference state |
| @ObservedObject       | ❌ No          | Observer                  |
| @EnvironmentObject    | ❌ No          | Inject                    |
| @Binding              | ❌ No          | Reference state           |
""", result: nil),
        Lesson(title: "How creates Binding", code: """
🔹 From @State
@State private var name = ""
TextField("Name", text: $name)

$name = Binding<String>

🔹 Manual Binding
Binding( 
    get: { self.name }, 
    set: { self.name = $0 }
)
""", result: nil),
        Lesson(title: "Advanced Binding Patterns"),
        Lesson(title: "1️⃣ Binding Transform (Mapping Binding)", code: """
❗ Problem
You have:
    @State var isOn: Bool

But you need:
    Binding<String>

✅ Solution: transform binding
let stringBinding = Binding<String>(
    get: { isOn ? "ON" : "OFF" },
    set: { isOn = ($0 == "ON") }
)
""", result: nil)
    ]
}
