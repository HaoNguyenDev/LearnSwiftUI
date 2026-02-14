//
//  ObservableMacroLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/2/26.
//

import SwiftUI

struct ObservableMacroLesson {
    static let all = [
        Lesson(title: "1️⃣ Core Definition", code: """
❓ What is the Observation Framework?

Observation is Apple's new framework (iOS 17) that helps SwiftUI track model changes without needing ObservableObject and @Published anymore.

Instead of:
class UserViewModel: ObservableObject {
    @Published var name: String = ""
}

We use:
@Observable
class UserViewModel {
    var name: String = ""
} 

No need for:
❌ ObservableObject
❌ @Published

❓ How does @Observable work?
@Observable is a macro (compile-time code generation).

It automatically:
- Tracks property changes
- Creates dependency tracking mechanisms
- Notifies SwiftUI views that need re-rendering
""", result: nil),
        Lesson(title: "2️⃣ Problems Solved by @Observable", code: """
❌ Old problems with ObservableObject
- Remember to add @Published
- Nested objects don't propagate themselves
- Updates aren't optimized (invalidates the entire object)
- Performance isn't good in large trees

✅ @Observable improves
- Tracking at the property level
- Nested objects work naturally
- Better performance
- Boilerplate significantly reduced
""", result: nil),
        Lesson(title: "3️⃣ Standard Usage", code: #"""
Basic example:

import Observation
@Observable
class CounterViewModel { 
    var count: Int = 0 

    func increment() { 
        count += 1 
    }
}

In View:

import SwiftUI
struct CounterView: View { 
    @State private var viewModel = CounterViewModel() 

    var body: some View { 
        VStack { 
            Text("Count: \(viewModel.count)") 
            Button("Increment") { 
                viewModel.increment() 
            } 
        } 
    }
}

⚠️ Extremely important note
With @Observable, we use:
@State var viewModel = ...

DO NOT use:
@StateObject
@ObservedObject
"""#, result: nil),
        Lesson(title: "4️⃣ Dependency Tracking — The Most Important Mechanism", code: """
SwiftUI only re-renders the view if that property is read in the body.
Example:
Text(viewModel.count)
→ only re-renders when count changes.

If the class has:
var name: String = ""
→ changing name does NOT cause the view to re-render if the name is not used in the body.

🔥 This is a very common question in job interviews.
""", result: nil),
        Lesson(title: "5️⃣ Nested Observable (Key Feature)", code: """
With the old system
Nested objects require manual wiring.
With Observation
@Observable
class Profile {
    var username: String = ""
}

@Observable
class UserViewModel {
    var profile = Profile()
}

In the View:
Text(viewModel.profile.username)

→ When the username changes, the view updates automatically.
No need for:
- @Published
- Combine
- objectWillChange
""", result: nil),
        Lesson(title: "6️⃣ @Bindable — When Binding Is Needed", code: """
If you want to pass binding to a subview:
struct EditView: View {
    @Bindable var viewModel: CounterViewModel

    var body: some View {
        TextField("Count", value: $viewModel.count, format: .number)
    }
}
""", result: nil),
        Lesson(title: "7️⃣ Important Comparisons", code: """
| Old              |    New             |
| ---------------- | ---------------    |
| ObservableObject | @Observable        |
| @Published       | No need            |
| @StateObject     | @State             |
| Combine-based    | Native tracking    |
| objectWillChange | Auto               |
""", result: nil),
        Lesson(title: "8️⃣ Common Errors", code: """
❌ Error 1: Using @StateObject with @Observable
Incorrect:
    @StateObject var vm = CounterViewModel()
Correct:
    @State var vm = CounterViewModel()

❌ Error 2: Not importing Observation
import Observation

❌ Error 3: Not understanding dependency tracking
View doesn't update because that property isn't read in the body.
""", result: nil)
    ]
}
