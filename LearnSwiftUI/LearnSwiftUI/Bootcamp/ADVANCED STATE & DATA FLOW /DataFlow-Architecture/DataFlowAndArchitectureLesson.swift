//
//  DataFlowAndArchitectureLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/1/26.
//

import Foundation

struct DataFlowAndArchitectureLesson {
    static let all: [Lesson] = [
        Lesson(title: "State Flow Architecture", code: """
Why do we need "State Flow Architecture"?

When the app is small:
    View → @State → Update UI

When the app is large:
- Multiple screens
- Shared state
- Complex business logic
- Networking / async
- Dependency injection
- Testability

Without a clear state architecture:
❌ State is mutated from multiple places
❌ Views contain business logic
❌ Bugs are difficult to debug
❌ Hard to test
❌ Data flow is uncontrolled

Therefore, we need:
State Flow Architecture = An architecture that controls how state is created, passed, mutated, and rendered.

✅ SwiftUI (one-way data flow)

    State (source of truth)
        ↓
    View
        ↓
    User Action
        ↓
    Intent
        ↓
    Update State
        ↓
    Re-render View

📌 Immutable Law
View does NOT hold the source state,
View only reflects the state.
""", result: nil),
        Lesson(title: "What is Unidirectional Data Flow (UDF)?", code: """
1️⃣ Core Definition
Unidirectional Data Flow is a model in which:
- State flows in only one direction
- Events flow in the opposite direction
- Views do not directly mutate state

2️⃣ Standard UDF Cycle
State → View → User Action → Intent → Update State → Re-render View

or
        ┌──────────┐
        │   State  │
        └────┬─────┘
             ↓
        ┌──────────┐
        │   View   │
        └────┬─────┘
             ↓
        ┌──────────┐
        │  Action  │
        └────┬─────┘
             ↓
        ┌──────────┐
        │ Reducer  │
        └────┬─────┘
             ↓
        ┌──────────┐
        │  NewState│
        └──────────┘

""", result: nil),
        Lesson(title: "Two-way vs. one-way comparison", code: """
❌ Two-way binding (no control)

    TextField("Name", text: $viewModel.name)

- TextField directly mutates the state.
- Suitable for simple UI,
but dangerous when:
- State depends on complex logic
- Has validation
- Has business rules

✅ Unidirectional
TextField("Name", text: Binding(
    get: { viewModel.state.name },
    set: { viewModel.send(.nameChanged($0)) }
))

Here:
- View does not mutate state
- View sends action
- Reducer handles
- State update is centralized
→ 100% control
""", result: nil),
        Lesson(title: "3️⃣ @Binding — NOT a state ❗", code: """
🧠 Correct definition
    @Binding does not store data,
it is only a controlled reference to state elsewhere.

Example:

    struct ChildView: View {
        @Binding var isOn: Bool
    }

📌 @Binding:
No ownership
No lifecycle retention
Write/Read only

❌ Common mistake

    @Binding var text = ""

➡️ ❌ @Binding has no default value
""", result: nil),
        Lesson(title: "4️⃣ Rules for Setting State (Secondary State Must Belong)", code: """
🔑 Rule 1
    State must be set as high as possible,
    but as low as necessary.

📍 Example:
    State used for the entire screen → set in Screen
    State used for 1 row → set in Row

🔑 Rule 2
    Do not raise state just for "convenience"
    Raising the wrong state = coupling + bug
""", result: nil),
        Lesson(title: "5️⃣ @Environment & @EnvironmentObject", code: """
🧠 When to use?
    State used for multiple branches
    Do not want to pass through multiple levels

Example:
    @Environment(.colorScheme)
    @EnvironmentObject var session: SessionStore

⚠️ Senior Warning
    @EnvironmentObject is a global implicit dependency
    ❌ Use indiscriminately → difficult to debug

✅ Only use for:
    Auth
    Theme
    App-level state
""", result: nil),
        Lesson(title: "6️⃣ ViewModel in SwiftUI — NOT LIKE UIKit", code: """
❌ UIKit mindset (wrong in SwiftUI)
    ViewModel holds layout logic
    ViewModel determines UI

✅ SwiftUI ViewModel is correct
    ViewModel only holds state & business logic
    View determines UI

Example:

    final class LoginViewModel: ObservableObject {
        @Published var email = ""
        @Published var isLoading = false
    }

    struct LoginView: View {
        @StateObject var vm = LoginViewModel()
    } 

📌 ViewModel does NOT know SwiftUI
""", result: nil),
        Lesson(title: "7️⃣ One-way Data Flow & Identity", code: """
🔥 Classic Bugs
    State set to the wrong level
    Identity changed
    State reset
➡️ Not a SwiftUI bug
➡️ Incorrect data flow

🧪 QUICK LAB — Identifying incorrect data flow
❌ Incorrect
    struct RowView {
        @State var isSelected
    }
➡️ Each row has its own truth → inconsistent

✅ Correct
    @State var selectedID
    RowView(
        isSelected: selectedID == item.id
    ) 
➡️ Single source of truth
""", result: nil)
    ]
}
