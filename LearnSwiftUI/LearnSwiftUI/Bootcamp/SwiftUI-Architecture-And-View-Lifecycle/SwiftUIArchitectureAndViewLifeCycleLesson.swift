//
//  SwiftUIArchitectureAndViewLifeCycleLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

struct SwiftUIArchitectureAndViewLifeCycleLesson {
    static let all = [Lesson(title: "SwiftUI Architecture Overview", code: """
Declarative vs. Imperative Programming

SwiftUI is declarative: you describe "what" not "how"
View is a function of state: View = f(State)
Automatic UI updates when state changes

Declarative vs Imperative
// ❌ IMPERATIVE (UIKit style) 

let label = UILabel() 
label.text = "Hello" 
label.textColor = .blue 
label.font = .systemFont(ofSize: 20) 
view.addSubview(label)

// When data changes: 
func updateLabel(with newText: String) { 
    label.text = newText // Manual update 
}

// ✅ DECLARATIVE (SwiftUI) 
Text("Hello") 
    .foregroundColor(.blue) 
    .font(.system(size: 20))

// When data changes: SwiftUI automatically updates! 

@State private var text = "Hello"
Text(text) // Automatically updates when text changes

Core Principle: View = f(State)
// View is a pure function of State

func render(state: AppState) -> View {
    // Same state ALWAYS produces the same view
    return Text(state.message)
}
""", result: nil),
                      
                      Lesson(title: "Rendering Pipeline", code: """
// SwiftUI engine:
// 1. State changes
// 2. SwiftUI calls the body again
// 3. Compare with the old view tree (diffing algorithms)
// 4. Only update the changed part

State / Input / Environment
        ↓
   View invalidated
        ↓
      body()
        ↓
     Diff Tree (diffing algorithms)
        ↓
Update / Reuse / Destroy

Body is NOT a UI renderer.

A body is simply:
    👉 A pure function that returns a new View Tree.
SwiftUI will:
    Call the body.
    Get the new tree.
    Diff with the old tree.
    Decide to update/reuse/destroy.
📌 Remember:
If the body is rerun ≠ the view is recreated.
If the body is rerun = SwiftUI is preparing to diff.

    User changes @State
            ↓
    RECOMPUTE (calculates new body)
            ↓
    SwiftUI diff old vs new body (diffing algorithms)
            ↓
    ┌──────────────┬──────────┐
    ↓              ↓          ↓
DO NOT CHANGE   RELAYOUT    REDRAW
""", result: nil),
                      
                      Lesson(title: "View Protocol & Body Property", code: """
View Protocol Deep Dive

Every View must conform to the View protocol
Body property returns some View (Opaque type)
View is a struct (value type), not a class
Views are created and destroyed continuously (cheap to create)


public protocol View {
    associatedtype Body : View
    @ViewBuilder var body: Self.Body { get }
}

// Implementation example:

struct MyView: View { 
    // Body MUST return a View 
    var body: some View { // Opaque return type 
        Text("Hello") 
    }
}

Opaque Types: some View

// some View = Opaque Type
// Compiler knows exact type, but hidden from caller

// ✅ GOOD: Opaque type

    func makeView() -> some View { 
        Text("Hello") // Compiler knows this is Text
    }

// ❌ BAD: Type erasure

    func makeView() -> AnyView { 
        AnyView(Text("Hello")) // Lost type info
    }

// Why opaque types matter:

    struct ContentView: View { 
        var body: some View { // Compiler: Text<String> 
            Text("Hello") 
        }
    }

// Compiler optimization:
// - Knows exact memory layout
// - Can inline code
// - No dynamic dispatch
// - View diffing is O(1) instead of O(n)
""", result: nil),
                      Lesson(title: "View Lifecycle", code: """
View Creation & Destruction

Example:

struct CounterViewExample: View {
    @State private var count = 0
    
    init() {
        debugPrint("🏗️ View struct created")
        // Called MANY times - every render time!
    }
    
    var body: some View {
        debugPrint("🎨 Body evaluated")
        return VStack {
            Text("Count: (count)")
            Button("Increment") {
                count += 1
            }
        }
    }
}

// Output when running:
// 🏗️ View struct created
// 🎨 Body evaluated
// [User clicks button]
// 🏗️ View struct created ← Create again!
// 🎨 Body evaluated

Important: View structs are created every time a render is performed, but:

Structs are very cheap (stack allocation)
State is managed separately by SwiftUI
View lifetime ≠ State lifetime
""", result: {
        AnyView(ResultBlockView(content: {
            CounterViewExample()
        }))
    }),
                      Lesson(title: "View Identity", code: """
// 1. STRUCTURAL IDENTITY (default)
struct ConditionalViewExample: View {
    @State private var showRed = true
    
    var body: some View {
        debugPrint("🎨 ConditionalViewExample Body evaluated")
        return VStack {
            if showRed {
                CustomCircleViewIdentityTest(.red) // Identity = position in tree
                    .frame(height: 100)
            } else {
                CustomCircleViewIdentityTest(.blue) // DIFFERENT identity!
                    .frame(height: 100)
            }
            
            Button("Toggle") {
                showRed.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
}
// When toggle: Red circle destroyed, Blue circle created, new circle with new ID created

struct CustomCircleViewIdentityTest: View {
    @State private var viewID = UUID()
    var background: Color
    
    init(_ background: Color) {
        debugPrint("🏗️ CustomCircleViewIdentityTest View struct created")
        // Called every render time!
        self.background = background
    }

    var body: some View {
        debugPrint("🎨 CustomCircleViewIdentityTest Body evaluated")
        return Circle()
            .fill(background)
            .overlay {
                Text("(viewID)")
            }
    }
}

""", result: {
        AnyView(ResultBlockView(content: {
            ConditionalViewExample()
        }))
    }),
                      Lesson(title: "", code: """
// 2. EXPLICIT IDENTITY with .id()
struct StableIdentityViewExample: View {
    @State private var showRed = true
    init() {
        debugPrint("🏗️ StableIdentityViewExample View struct created")
        // Called every render time!
    }
    
    var body: some View {
        debugPrint("🎨 StableIdentityViewExample Body evaluated")
        return VStack {
            CustomCircleViewIdentityTest(showRed ? .red : .blue)
//                .id(stableID) // Stable identity
                .frame(height: 100)
            Button("Toggle") {
                showRed.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
}
// When toggle: Same circle with the same ID, only color changed
""", result: {
        AnyView(ResultBlockView(content: {
            StableIdentityViewExample()
        }))
    }),
                      Lesson(title: "", code: """
// 3. IDENTITY in List
struct ItemListViewIdentityTest: View {
    let items = ["A", "B", "C"]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: .self) { item in
                    Text(item)
                        .background(FillShapeStyle())
                }
            }
        }
    }
}
// SwiftUI tracks each item by id
""", result: {
        AnyView(ResultBlockView(content: {
            VStack {
                ItemListViewIdentityTest()
            }
        }))
    }),
                      Lesson(title: "View Identity Performance Impact", code: """
// ❌ BAD: Recreate view every toggle

struct BadApproach: View { 
    @State private var isExpanded = false 

    var body: some View { 
        if isExpanded { 
            ExpandedView() // New instance each time 
        } else { 
            CollapsedView() // New instance each time 
        } 
    }
}

// ✅ GOOD: Reuse view, only change state
struct GoodApproach: View { 
    @State private var isExpanded = false 

    var body: some View { 
        FlexibleView(isExpanded: isExpanded) 
        // Same view, different state 
    }
}
```

---

### **1.4 SwiftUI Rendering Pipeline**

#### **4-Stage Rendering Process**
```
1. VIEW CREATION 
        ↓
2. BODY EVALUATION 
        ↓
3. LAYOUT CALCULATION
        ↓
4. RENDERING
""", result: nil),
                      Lesson(title: "Question???", code: """
Q: How does view identity work?
A:
Structural identity: Based on position in the view tree
Explicit identity: Uses the .id() modifier
Identity determines whether the view is updated or recreated
Important for animations and state preservation
""", result: nil),
                      Lesson(title: "", code: """
Q: Differentiate between View tree and Render tree
A:
View tree: Logical hierarchy (VStack, HStack, Text...)
Render tree: Actual rendering commands (DrawText, DrawShape...) SwiftUI converts view tree → render tree
Optimization occurs at this conversion step
""", result: nil),
                      Lesson(title: "", code: """
Q: How does the SwiftUI diffing algorithm work?
A:
SwiftUI uses structural diffing:
// 1. Compare view types
// 2. If same type, compare properties
// 3. If different type, recreate
// 4. Use identity for tracking

// Example:

ForEach(items, id: .id) { item in 
    ItemView(item: item)
}

// SwiftUI tracks each ItemView by item.id
// When items change: add/remove/move operations
""", result: nil),
                      Lesson(title: "", code: """
Q: Why should you not use AnyView?
A:
Type erasure → takes compile-time type info
SwiftUI cannot optimize view diffing
Cannot inline code
Performance penalty: dynamic dispatch
Only use when really needed (very rare)
""", result: nil),
                      Lesson(title: "", code: """
Q: How does ViewBuilder transform code?
A:
// Input:

@ViewBuilder 
var content: some View { 
    Text("A") 
    Text("B") 
    if condition { 
        Text("C") 
    }
}

// Transform into:
var content: some View { 
    _ConditionalContent( 
        TupleView((Text("A"), Text("B"))),
        condition ? Text("C") : nil 
    )
}
""", result: nil),
                      Lesson(title: "", code: """
Q: How to debug view update performance?
A:
1. Use Self._printChanges()

    struct MyView: View { 
        @State private var count = 0 
        var body: some View { 
            let _ = Self._printChanges() 
            Text("(count)") 
        }
    }

// 2. Instruments: SwiftUI profiler
// 3. View body execution counter
// 4. TimelineView for monitoring
""", result: nil),
                      Lesson(title: "", code: """
""", result: nil),
                      Lesson(title: "", code: """
""", result: nil)
    ]
}
