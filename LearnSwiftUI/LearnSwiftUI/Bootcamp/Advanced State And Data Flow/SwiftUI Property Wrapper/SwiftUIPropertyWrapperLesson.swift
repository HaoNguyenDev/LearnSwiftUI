//
//  SwiftUIPropertyWrapperLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 12/2/26.
//

import SwiftUI

struct SwiftUIPropertyWrapperLesson {
    static let all = [
        Lesson(title: "ObservableObject, Published. @StateObject vs @ObservedObject"),
        Lesson(title: "1️⃣ CORE PROBLEM", code: """
SwiftUI is a declarative UI framework.

→ UI = function(state)
→ When state changes → view re-render

But:
@State is only used for local state
When state belongs to the model layer (MVVM)
When multiple views need to share the same source of truth
When state has a lifecycle independent of the View
👉 We need ObservableObject
""", result: nil),
        Lesson(title: "2️⃣ What is an ObservableObject?", code: """
📌 Standard Definition
An ObservableObject is a protocol used for reference types (classes)
that allows SwiftUI to monitor changes in objects and update the View when the object signals a change.

Example code:

class CounterViewModel: ObservableObject {
    @Published var count: Int = 0
}

SwiftUI tracks:

objectWillChange publisher

Every time @Published changes → SwiftUI invalidate view

""", result: nil),
        Lesson(title: "3️⃣ How does @Published work?", code: """
📌 Inside

@Published var count: Int

Essentially:
Wrap value
Sends a signal via objectWillChange
SwiftUI subscribes to this publisher

Approximate equivalent:

var count: Int { 
    willSet { 
        objectWillChange.send() 
    }
}

⚠️ Note:
Only trigger when the property assigns a new value.
If it's a nested struct, deep mutations may not trigger.
""", result: nil),
        Lesson(title: "4️⃣ @StateObject vs @ObservedObject", code: """
🔵 @StateObject
📌 Definition
@StateObject creates and maintains the lifecycle of an ObservableObject.

SwiftUI:
Creates an object only once
Maintains the object through body re-renders

struct ContentView: View {
    @StateObject private var viewModel = CounterViewModel()
} 

📌 When to use it?
The View is the owner of the ViewModel
The View creates the ViewModel
The View needs to maintain a stable lifecycle
When view recreates, the object is not lost.

🔴 @ObservedObject
📌 Definition
@ObservedObject is used to observe an object that has been created elsewhere.

SwiftUI:
Does not maintain a lifecycle
If the view recreates → the object can be recreated if not held outside
struct ChildView: View {
    @ObservedObject var viewModel: CounterViewModel
} 

📌 When to use?
View is not the owner
Object is injected from the parent
""", result: nil),
        Lesson(title: "5️⃣ Visual comparison", code: """

|                     | @StateObject              | @ObservedObject |
| -----------------   | -----------------------   | --------------- |
| Create object       | Yes                       | No              |
| Keep lifecycle      | Yes                       | No              |
| Owner               | Yes                       | No              |
| When view recreate  | the object is not lost.   | Can lost        |

""", result: nil),
        Lesson(title: "6️⃣ Extremely Important Visual Examples", code: #"""
❌ Common Mistakes

struct ParentView: View {
    var body: some View {
        ChildView()
    }
}

struct ChildView: View {
    @ObservedObject var vm = CounterViewModel()
}
👉 Every time the body runs again → the vm is recreated
👉 State reset

✅ Correct Way
struct ParentView: View {
    @StateObject private var vm = CounterViewModel()

    var body: some View {
        ChildView(vm: vm)
    }
}

struct ChildView: View {
    @ObservedObject var vm: CounterViewModel
}
"""#, result: nil),
        Lesson(title: "7️⃣ Lifecycle Flow Diagram", code: """
View init
    ↓
@StateObject create object
    ↓
View re-render
    ↓
Object not recreate

        vs

View init
    ↓
@ObservedObject create object
    ↓
View re-render
    ↓
Object recreate

""", result: nil),
        Lesson(title: "8️⃣ Common production errors", code: """
⚠️ 1. Multiple network calls due to recreated ViewModel

@ObservedObject var vm = NetworkViewModel()
→ Persistent callback API

⚠️ 2. Data reset when navigating back
Because ViewModel is destroyed

⚠️ 3. Memory leak
When:
ViewModel holds a strong reference to View
Combine retain cycle
""", result: nil),
        Lesson(title: "9️⃣ Nested ObservableObject problem", code: """
class ParentVM: ObservableObject { 
    @Published var child = ChildVM()
}
When child.property changes
👉 Parents do not automatically emit changes

Solution:
Manually forward objectWillChange
Or flatten state
""", result: nil),
        Lesson(title: "Interview Questions"),
        Lesson(title: "10 Interview Deep Questions", code: """
❓1. When does SwiftUI recreate a view?
When the state changes
When the identity changes
When the parent changes

❓2. Why should @StateObject be used at the top level?
Because it determines ownership and the lifecycle

❓3. How does objectWillChange work?
It combines the publisher, the view subscribes, and the view invalidates.

❓4. Why shouldn't @ObservedObject be used in the root view?
Because it doesn't maintain the lifecycle → recreate.

❓5. Is ObservableObject thread-safe?
No.
Updates must go to the main thread if they affect the UI.
""", result: nil)
    ]
}
