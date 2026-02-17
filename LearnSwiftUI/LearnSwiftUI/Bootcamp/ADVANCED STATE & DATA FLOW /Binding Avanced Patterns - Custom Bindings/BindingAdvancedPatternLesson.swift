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

SwiftUI follows this model:
State (source of truth)
    ↓
View
    ↓
User action
    ↓
Binding set
    ↓
State update
    ↓
Re-render

Binding is just a bridge.
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
""", result: nil),
        Lesson(title: "2️⃣ Binding with Collections", code: """
❗ Problem
@State var items: [Todo]

How to bind each element?

✅ Correct way
ForEach($items) { $item in
    Toggle(item.title, isOn: $item.isDone)
} 

SwiftUI creates binding for each element.
""", result: {
    AnyView(ResultBlockView(content: {
        CollectionBindingExampleParrent()
    }))
}),
        Lesson(title: "3️⃣ Binding Optional", code: """
SwiftUI doesn't like optional binding.
❌ Wrong
TextField("Name", text: $user.name) // if user is optional

✅ Yes
if let userBinding = Binding($user) { 
    TextField("Name", text: userBinding.name)
}

Or custom unwrap:
extension Binding { 
func unwrap<T>() -> Binding<T>? where Value == T? { 
    guard let value = wrappedValue else { return nil } 
        return Binding<T>( 
            get: { value }, 
            set: { wrappedValue = $0 } 
        ) 
    }
}

// ✅ Use unwrap() to convert Binding<Task?> → Binding<Task> 
if let taskBinding = $selectedTask.unwrap() { 
    DetailView(task: taskBinding) // Binding<Task> ✅ 
}
""", result: nil),
        Lesson(title: "Advanced Knowledge (Very Important)", code: """
1️⃣ Identity Binding
Binding doesn't have its own identity → identity is based on the source state.

2️⃣ Binding and Diffing
SwiftUI doesn't diff binding → view diff.

3️⃣ Binding doesn't trigger re-rendering
Only state changes trigger it.

4️⃣ Binding is a value type
It's a struct.

Important Thinking
👉 State must have a source of truth
👉 Binding is just a way to mutate state
👉 Never let a View hold multiple different sources of state
""", result: nil),
        Lesson(title: "Common errors", code: """
1️⃣ Infinite update loop
set: { age = $0; age = age + 1 }
→ May cause loop render.

2️⃣ Binding capture stale value
let value = someState
Binding(get: { value }, set: { value = $0 }) ❌

3️⃣ Using .constant in the wrong place
.constant = read-only binding
""", result: nil)
    ]
}
