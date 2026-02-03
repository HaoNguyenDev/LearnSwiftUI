//
//  StateManagementDeepDiveLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct StateManagementDeepDiveLesson {
    static let all = [Lesson(title: "@State - Single Source of Truth", code: """
What is @State and how does it work?

struct CounterView: View { 
    @State private var count = 0 // Property wrapper 

    var body: some View { 
        Text("(count)") 
    }
}

// Compiler transforms into:
struct CounterView: View { 
    private var _count = State(initialValue: 0) 

    private var count: Int { 
        get { _count.wrappedValue } 
        nonmutating set { _count.wrappedValue = newValue } 
    } 

    var body: some View { 
        Text("(count)") 
    }
}
""", result: nil),
                      Lesson(title: "Key Concepts", code: """
Where is @State saved?

    DO NOT save in View struct (because struct is immutable)
    SwiftUI is stored in separate persistent storage
    Each @State has a unique ID, which SwiftUI tracks through the view identity

// Visualization:
// View Structure (Stack) → @State Storage (Heap)
// CounterView → count: 0
// ↓ recreated ↓ persists
// CounterView → count: 5
// ↓ recreated ↓ persists
// CounterView → count: 10
""", result: nil),
                      Lesson(title: "Lifetime of @State", code: """
struct ParentView: View { 
    @State private var showChild = true 

    var body: some View { 
        VStack { 
            if showChild { 
                ChildView() // ChildView's @State created 
            } 
            // When showChild = false → ChildView destroyed 
            // → @State also destroyed! 
        } 
    }
}

struct ChildView: View { 
    @State private var counter = 0 

    var body: some View { 
        Text("(counter)") 
    }
}

// @State lifetime = View identity lifetime
""", result: nil),
                      Lesson(title: "@State triggers view update", code: """
struct UpdateDemo: View {
    @State private var value = 0
    
    var body: some View {
        let _ = print("Body called")  // Debug
        
        VStack {
            Text("(value)")
            Button("Update") {
                value += 1  // Triggers body re-evaluation
            }
        }
    }
}

// Flow:
// 1. Button tapped
// 2. value += 1
// 3. SwiftUI detects @State change
// 4. Mark view as "needs update"
// 5. Call body property
// 6. Diff with old view tree
// 7. Update only changed parts
""", result: nil),
                      Lesson(title: "@State Best Practices", code: """
Rule 1: Always private

// ❌ BAD: Public @State
struct BadView: View { 
    @State var counter = 0 // Anyone can modify!
}

// ✅ GOOD: Private @State
struct GoodView: View { 
    @State private var counter = 0 // Encapsulated
}

// Why? @State is view's internal state, should not be exposed

Rule 2: Value types only
// ✅ GOOD: Value types
@State private var count: Int = 0
@State private var name: String = ""
@State private var isOn: Bool = false
@State private var items: [String] = [] // Array is a value type

// ❌ BAD: Reference types
@State private var viewModel = ViewModel() // Use @StateObject!
@State private var manager = DataManager() // Use @StateObject!

// Exception: Reference types work but do not trigger updates
class Counter { 
    var value = 0 // Changes don't trigger view update!
}

struct BadExample: View { 
    @State private var counter = Counter() 

    var body: some View { 
        Button("Increment") { 
            counter.value += 1 // No view update! 
        } 
    }
}

Rule 3: Minimal state
swift// ❌ BAD: Redundant state
struct BadCalculator: View {
    @State private var number1 = 0
    @State private var number2 = 0
    @State private var sum = 0  // Redundant!
    
    var body: some View {
        VStack {
            TextField("Number 1", value: $number1, format: .number)
            TextField("Number 2", value: $number2, format: .number)
            Text("Sum: (sum)")
        }
        .onChange(of: number1) { _, _ in sum = number1 + number2 }
        .onChange(of: number2) { _, _ in sum = number1 + number2 }
    }
}

// ✅ GOOD: Computed property
struct GoodCalculator: View {
    @State private var number1 = 0
    @State private var number2 = 0
    
    private var sum: Int {  // Computed, not stored
        number1 + number2
    }
    
    var body: some View {
        VStack {
            TextField("Number 1", value: $number1, format: .number)
            TextField("Number 2", value: $number2, format: .number)
            Text("Sum: (sum)")
        }
    }
}
""", result: {
        AnyView(ResultBlockView(content: {
            GoodCalculator()
        }))
    }),
    Lesson(title: "@Binding - Two-way Connection", code: """
What's @Binding?
// @Binding creates a reference to @State

struct ParentView: View {
    @State private var isOn = false  // Source of truth
    
    var body: some View {
        ToggleView(isOn: $isOn)  // Pass binding
    }
}

struct ToggleView: View {
    @Binding var isOn: Bool  // Reference to parent's @State
    
    var body: some View {
        Toggle("Switch", isOn: $isOn)
    }
}

// Flow:
// Parent @State ←→ Child @Binding
// Changes in either side sync automatically
""", result: {
        AnyView(ResultBlockView(content: {
            BindingExample()
        }))
    }),
    Lesson(title: "@Binding Implementation", code: """
// Simplified implementation:

@propertyWrapper
struct MyBinding<Value> {
    var wrappedValue: Value {
        get { getter() }
        nonmutating set { setter(newValue) }
    }
    
    private let getter: () -> Value
    private let setter: (Value) -> Void
    
    init(get: @escaping () -> Value, set: @escaping (Value) -> Void) {
        self.getter = get
        self.setter = set
    }
}

// When you write:
@MyBinding var isOn: Bool

// You're creating a reference that:
// - Reads from parent's storage
// - Writes to parent's storage
""", result: nil),
                      
    Lesson(title: "Binding Patterns", code: """
""", result: nil),
    Lesson(title: "Pattern 1: Parent → Child communication", code: """
struct ParentView: View {
    @State private var username = ""
    
    var body: some View {
        VStack {
            Text("Hello, (username)")
            UsernameInput(username: $username)
        }
    }
}

struct UsernameInput: View {
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username)
    }
}
""", result: {
        AnyView(ResultBlockView(content: {
            ParentAndChildCommunicationExample()
        }))
    }),
    Lesson(title: "Pattern 2: Custom bindings", code: """
struct TemperatureView: View {
    @State private var celsius: Double = 0
    
    // Custom binding: Fahrenheit ↔ Celsius
    private var fahrenheitBinding: Binding<Double> {
        Binding(
            get: { celsius * 9/5 + 32 },
            set: { celsius = ($0 - 32) * 5/9 }
        )
    }
    
    var body: some View {
        VStack {
            TextField("Celsius", value: $celsius, format: .number)
            TextField("Fahrenheit", value: fahrenheitBinding, format: .number)
        }
    }
}
""", result: {
        AnyView(ResultBlockView(content: {
                TemperatureViewCustomBinding()
            }))
    }),
    Lesson(title: "Binding with Optional", code: """
struct OptionalBindingView: View {
    @State private var selectedItem: Item?
    
    var body: some View {
        VStack {
            Button("Select") {
                selectedItem = Item(name: "Test")
            }
            
            // Unwrap optional binding
            if let binding = Binding($selectedItem) {
                ItemDetailView(item: binding)
            }
        }
    }
}

// Helper extension:
extension Binding {
    init?(_ binding: Binding<Value?>) {
        guard let value = binding.wrappedValue else {
            return nil
        }
        self.init(
            get: { binding.wrappedValue ?? value },
            set: { binding.wrappedValue = $0 }
        )
    }
}
""", result: nil),
    Lesson(title: "@State vs @Binding Decision Tree**", code: """
Does the view OWN the data? 
│ 
├─ YES → @State 
│ ├─ private 
│ ├─ Source of truth 
│ └─ Example: @State private var counter = 0 
│ 
└─ NO → @Binding 
├─ Shared with parents 
├─ Reference to parent's @State 
└─ Example: @Binding var counter: Int


Examples:
// View owns data → @State
struct ExpandableCard: View {
    @State private var isExpanded = false  // Internal state
    
    var body: some View {
        VStack {
            // ... card content
        }
    }
}

// View doesn't own data → @Binding
struct TextField: View {
    @Binding var text: String  // Parent owns the text
    
    var body: some View {
        // ... text field implementation
    }
}
""", result: nil)]
}
