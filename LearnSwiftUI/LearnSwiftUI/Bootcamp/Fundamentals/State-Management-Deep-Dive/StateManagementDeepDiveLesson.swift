//
//  StateManagementDeepDiveLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct StateManagementDeepDiveLesson {
    static let all = [
        Lesson(title: "PART 1: CORE KNOWLEDGE", code: "", result: nil),
                      Lesson(title: "@State - Single Source of Truth", code: """
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
""", result: nil),
                      Lesson(title: "PARD 2: ADVANCED STATE PATTERNS", code: "", result: nil),
                      Lesson(title: "State Hoisting", code: """

 State Hoisting

// ❌ BAD: State too low in hierarchy
struct BadExample: View {
    var body: some View {
        VStack {
            CounterDisplay()
            CounterButton()
            // Problem: Can't share counter between views!
        }
    }
}

struct CounterDisplay: View {
    @State private var count = 0  // Isolated state
    
    var body: some View {
        Text("(count)")
    }
}

// ✅ GOOD: Hoist state to parent
struct GoodExample: View {
    @State private var count = 0  // Shared state
    
    var body: some View {
        VStack {
            CounterDisplay(count: count)
            CounterButton(count: $count)
        }
    }
}

struct CounterDisplay: View {
    let count: Int
    var body: some View { Text("(count)") }
}

struct CounterButton: View {
    @Binding var count: Int
    var body: some View {
        Button("Increment") { count += 1 }
    }
}

Rule of Thumb:

Hoist state to the lowest common ancestor.
Do not hoist too high (performance).
Do not let it be too low (can't share).
""", result: {
        AnyView(ResultBlockView(content: {
            SharedStateExample()
        }))
    }),
                      Lesson(title: "Derived State", code: """
// Derived state = State calculated from other state

struct TodoList: View {
    @State private var todos: [Todo] = []
    @State private var filter: Filter = .all
    
    // ✅ Derived state: Computed property
    private var filteredTodos: [Todo] {
        switch filter {
        case .all: return todos
        case .active: return todos.filter { !$0.isCompleted }
        case .completed: return todos.filter { $0.isCompleted }
        }
    }
    
    // ✅ Derived state: Statistics
    private var completionRate: Double {
        guard !todos.isEmpty else { return 0 }
        let completed = todos.filter(.isCompleted).count
        return Double(completed) / Double(todos.count)
    }
    
    var body: some View {
        VStack {
            ProgressView(value: completionRate)
            List(filteredTodos) { todo in
                TodoRow(todo: todo)
            }
        }
    }
}
""", result: nil),
                      Lesson(title: "State Normalization", code: """
// ❌ BAD: Nested duplicated state
struct BadUserList: View { 
    @State private var users: [User] = [ 
        User(id: 1, name: "Alice", posts: [Post(id: 1, title: "Hello")]), 
        User(id: 2, name: "Bob", posts: [Post(id: 2, title: "World")]) 
    ] 
// Problem: Post is duplicated if many users share
}

// ✅ GOOD: Normalized state
struct GoodUserList: View { 
    @State private var users: [Int: User] = [:] // Dictionary by ID 
    @State private var posts: [Int: Post] = [:] // Dictionary by ID 
    @State private var userPosts: [Int: [Int]] = [:] // User ID → Post IDs 

    var body: some View { 
        List(Array(users.values)) { users print 
            UserRow(user: user, posts: posts(for: user.id)) 
        } 
    } 

    private func posts(for userId: Int) -> [Post] { 
        let postIds = userPosts[userId] ?? [] 
        return postIds.compactMap { posts[$0] } 
    }
}
""", result: nil), Lesson(title: "PART 3: PERFORMANCE OPTIMIZATION", code: """
""", result: nil),
    Lesson(title: "", code: """
State Granularity

// ❌ BAD: Coarse-grained state
struct BadFormView: View { 
    @State private var formData = FormData() // Entire form is one state 

    var body: some View { 
        Form { 
            TextField("Name", text: $formData.name) 
            TextField("Email", text: $formData.email) 
            TextField("Phone", text: $formData.phone) 
            // Problem: Each keystroke updates the entire form! 
        } 
    }
}

// ✅ GOOD: Fine-grained state
struct GoodFormView: View { 
    @State private var name = "" 
    @State private var email = "" 
    @State private var phone = "" 

    var body: some View { 
        Form { 
            TextField("Name", text: $name) // Only name field updates 
            TextField("Email", text: $email) // Only email field updates 
            TextField("Phone", text: $phone) // Only phone field updates 
        } 
    }
}

// Trade-off: More @State properties vs performance
""", result: nil),
    Lesson(title: "Avoid Unnecessary Re-renders", code: """
// ❌ BAD: Parent re-renders all children
struct BadParent: View {
    @State private var counter = 0
    
    var body: some View {
        VStack {
            Text("(counter)")
            ExpensiveChildView()  // Re-renders everytime counter changes!
            ExpensiveChildView()
            ExpensiveChildView()
        }
    }
}

// ✅ GOOD: Extract stable views
struct GoodParent: View {
    @State private var counter = 0
    
    var body: some View {
        VStack {
            CounterView(counter: counter)  // Only this updates
            StaticChildView()  // No re-render
            StaticChildView()
            StaticChildView()
        }
    }
}

struct CounterView: View {
    let counter: Int
    var body: some View { Text("(counter)") }
}
""", result: nil), Lesson(title: " @State with Large Collections", code: """
// ❌ BAD: Mutate large arrays directly
struct BadListView: View {
    @State private var items: [Item] = Array(repeating: Item(), count: 10000)
    
    var body: some View {
        List {
            ForEach(items) { item in
                ItemRow(item: item)
            }
            Button("Add") {
                items.append(Item())  // Copies entire array!
            }
        }
    }
}

// ✅ BETTER: Use indices or IDs
struct BetterListView: View {
    @State private var items: [Item] = []
    
    var body: some View {
        List {
            ForEach(items.indices, id: .self) { index in
                ItemRow(item: items[index])
            }
        }
    }
}

// ✅ BEST: Use @StateObject and ObservableObject
class ItemStore: ObservableObject {
    @Published var items: [Item] = []
    
    func addItem() {
        items.append(Item())
    }
}

struct BestListView: View {
    @StateObject private var store = ItemStore()
    
    var body: some View {
        List(store.items) { item in
            ItemRow(item: item)
        }
    }
}
""", result: nil),
    Lesson(title: "INTERVIEW QUESTIONs", code: "", result: nil),
    Lesson(title: "", code: """
Junior Level:
Q1: What is the difference between @State and @Binding?
A:
@State:
    View owns the data
    Source of truth
    Private, local state
    Example: @State private var counter = 0

@Binding:
    View references parent's state
    Two-way connection
    Shared state
    Example: @Binding var counter: Int

Q2: Why must @State be private?
A:
    @State is the implementation detail of the view
    Encapsulation: state should not be accessed from outside
    SwiftUI manages the @State lifecycle
    If sharing is needed → use @Binding or @ObservedObject

Q3: Where is @State stored?
A:
    Not stored in View struct (struct is immutable)
    SwiftUI stores in separate persistent storage (heap)
    Lifetime tied to view identity
    When the view is destroyed → @State is also destroyed
""", result: nil),
    Lesson(title: "", code: """
Mid-Senior Level:
Q4: Explain "state hoisting" and why is it necessary?
A:
// State hoisting = put state on parent to share between children

// Problem: State too low
struct Problem: View { 
    var body: some View { 
        HStack { 
            ChildA() // Has @State counter 
            ChildB() // Has different @State counter 
            // Can't synchronize! 
        } 
    }
}

// Solution: Hoist to parent
struct Solution: View { 
@State private var counter = 0 // Shared 

    var body: some View { 
        HStack { 
            ChildA(counter: $counter) 
            ChildB(counter: $counter) 
            // Now synchronized! 
        } 
    }
}

Q5: How does Custom Binding work?
A:
// Custom binding transforms get/set
Binding( 
    get: { /* read transformation */ }, 
    set: { /* write transformation */ }
)

// Example: Uppercase binding
var uppercaseBinding: Binding<String> { 
Binding( 
    get: { text }, 
    set: { text = $0.uppercased() } 
)
}
Q6: When should you use derived state vs stored state?
A:
Derived (computed): When value can be calculated from existing state

swift 
    private var fullName: String { firstName + " " + lastName }

Stored (@State): When value is independent, cannot be derived

swift
    @State private var firstName = "" 
    @State private var lastName = ""
""", result: nil),
    Lesson(title: "", code: """
Q8: Are state updates atomic?
A:
// NO - State updates are NOT atomic!

@State private var counter = 0

// Problem:
DispatchQueue.global().async { 
    counter += 1 // ⚠️ Race condition!
}

DispatchQueue.global().async { 
    counter += 1 // ⚠️ Race condition!
}

// Solution 1: Dispatch to main
DispatchQueue.main.async { 
    counter += 1 // ✅ Safe
}

// Solution 2: Use actor
actor CounterStore { 
    private(set) var counter = 0 
    func increment() { counter += 1 }
}
Q9: Performance: @State with large struct?
A:
struct LargeData { 
    var array: [Int] = Array(repeating: 0, count: 10000) 
    var dict: [String: String] = [:]
}

// ❌ BAD: Copy-on-write penalty
@State private var data = LargeData()

// Every mutation copies entire struct!
data.array[0] = 1 // Copies 10000 elements!

// ✅ GOOD: Use class with @StateObject
class LargeDataStore: ObservableObject { 
    @Published var array: [Int] 
    @Published var dict: [String: String]
}

@StateObject private var store = LargeDataStore()
store.array[0] = 1 // No copy!

Q10: Explain @State transaction and animation:
A:
// @State changes can be animated
withAnimation { 
    isExpanded.toggle() // Animated state change
}

// SwiftUI creates Transaction:
struct Transaction { 
    var animation: Animation? 
    var disablesAnimations: Bool 
// ...
}

// Transaction wraps state changes:
// 1. Begin transaction
// 2. Apply state changes
// 3. Commit transaction
// 4. SwiftUI interpolates between old/new values
""", result: nil),
    Lesson(title: "Counter Exercise", code: """
struct CounterExercise: View {
    @State private var number = 0
    
    private var counterType: String {
        number.isMultiple(of: 2) ? "Even" : "Odd"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("(number)")
                .font(.system(size: 60, weight: .bold))
            
            Text(counterType)
                .font(.title)
                .foregroundColor(.secondary)

            HStack(spacing: 16) {
                Button("Decrease") {
                    number -= 1
                }
                .disabled(number == 0)
                
                Button("Increment") {
                    number += 1
                }
                
                Button("Reset") {
                    number = 0
                }
                .opacity(number == 0 ? 0.5 : 1)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
""", result: {
    AnyView(ResultBlockView(content: {
        CounterExercise()
    }))
}),
    Lesson(title: "ColorPicker Exercise", code: """
struct ColorPickerExercise: View {
    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    
    private var color: Color {
        Color(red: red, green: green, blue: blue)
    }
    
    private var hexCode: String {
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .fill(color)
                .frame(height: 200)
                .cornerRadius(12)
            
            Text(hexCode)
                .font(.system(.title, design: .monospaced))
            
            ColorSlider(value: $red, color: .red, label: "Red")
            ColorSlider(value: $green, color: .green, label: "Green")
            ColorSlider(value: $blue, color: .blue, label: "Blue")
        }
        .padding()
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    let color: Color
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("(label): (Int(value * 255))")
                .font(.caption)
            Slider(value: $value, in: 0...1)
                .accentColor(color)
        }
    }
}
""", result: {
    AnyView(ResultBlockView(content: {
        ColorPickerExercise()
    }))
}),
    Lesson(title: "TemperatureConverter Excercies", code: """
struct TemperatureConverter: View {
    @State private var celsius: Double = 0
    
    private var fahrenheitBinding: Binding<Double> {
        Binding(
            get: { celsius * 9/5 + 32 },
            set: { celsius = ($0 - 32) * 5/9 }
        )
    }
    
    private var kelvinBinding: Binding<Double> {
        Binding(
            get: { celsius + 273.15 },
            set: { celsius = $0 - 273.15 }
        )
    }
    
    var body: some View {
        Form {
            Section("Temperature") {
                HStack {
                    Text("Celsius")
                    Spacer()
                    TextField("", value: $celsius, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Fahrenheit")
                    Spacer()
                    TextField("", value: fahrenheitBinding, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Kelvin")
                    Spacer()
                    TextField("", value: kelvinBinding, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}
""", result: {
    AnyView(ResultBlockView(content: {
        TemperatureConverter()
    }))
}),
    Lesson(title: "OptimizedList Exercies", code: """
struct OptimizedList: View {
    @State private var items = Array(1...1000).map { Item(name: "Item ($0)") }
    @State private var filterText = ""
    @State private var debouncedFilter = ""
    @State private var filterTask: Task<Void, Never>?
    
    private var filteredItems: [Item] {
        guard !debouncedFilter.isEmpty else { return items }
        return items.filter { $0.name.localizedCaseInsensitiveContains(debouncedFilter) }
    }
    
    var body: some View {
        VStack {
            TextField("Filter", text: $filterText)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onChange(of: filterText) { _, newValue in
                    filterTask?.cancel()
                    filterTask = Task {
                        try? await Task.sleep(nanoseconds: 300_000_000) // 300ms debounce
                        if !Task.isCancelled {
                            debouncedFilter = newValue
                        }
                    }
                }
            
            List(filteredItems) { item in
                ItemRow(item: item)
            }
        }
    }
}
""", result: {
    AnyView(ResultBlockView(content: {
        OptimizedList()
    }))
})]
}
