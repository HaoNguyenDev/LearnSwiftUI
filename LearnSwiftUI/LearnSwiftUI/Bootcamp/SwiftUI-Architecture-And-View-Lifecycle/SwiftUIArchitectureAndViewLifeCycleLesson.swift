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
    Lesson(title: "some View - Opaque Return Type", code: """
What's some View?

Some View is an opaque type.
It allows you to hide the specific type of the View while still ensuring the compiler knows exactly what that type is.

Characteristics of Some View:

Compile-time fixed type: 
The compiler knows the exact return type,
but you don't need to explicitly declare it.

For example, if you return a Text, the compiler will know it's Text,
but the function signature only needs to be Some View.

Better performance:
Because the compiler knows the exact type at compile-time,
it can optimize the code better.
There is no memory or performance overhead like type erasure.

Type identity is preserved: 
Each instance of the view retains its type identity, helping SwiftUI optimize rendering and diffing.

Limitations in flexibility: 
You must return the same specific type in all cases.
You cannot return Text in one case and Image in another.

Example of some View:

var body: some View {
    Text("Hello SwiftUI")
}

func body() -> some View {
    VStack {
        Text("Username")
        if showDetails {
            Text("Further details")
        }
    }
}
// Compiler knows this is always VStack<TupleView<...>>
Note: In the example above, even with the if condition, the return type is still a fixed type (VStack contains a TupleView which may or may not have a second Text), not two different types.
""", result: nil),
    Lesson(title: "AnyView - Type Erasure", code: """
What is AnyView?

AnyView is a type-erased wrapper around any View. 
It "erases" specific type information and allows you to work with different Views flexibly.

Characteristics of AnyView:
Type flexibility: 
You can return completely different View types from the same function/property.

Performance overhead: 
Type erasure has a cost in memory and performance. 
SwiftUI cannot optimize any View as well as with some Views.

Loss of type identity: 
SwiftUI may have more difficulty tracking and optimizing view hierarchy.

Runtime type checking: 
Types are determined at runtime, not compile-time.

Example of AnyView:

struct DynamicView: View {
    let type: String

    var body: some View {
        getView()
    }

    // Returns completely different View types
    func getView() -> AnyView {
        switch type {
            case "text":
                return AnyView(Text("This is Text"))
            case "image":
                return AnyView(Image(systemName: "star"))
            case "button":
                return AnyView(Button("Press here") { })
            default:
                return AnyView(EmptyView())
            }
    }
}
""", result: nil),
    Lesson(title: "Detailed Comparison between some View vs AnyView", code: """
Comparison Table:
Criteria                Some View                     Any View
Type checking           Compile-time                  Runtime
Performance             High (good optimization)      Lower (has overhead) 
Memory                  Efficiency                    Overhead added     
Flexibility             Low (one fixed style)         High (many different styles) 
SwiftUI optimization    Good                          Poor 
When to use             Most cases                    When really necessary
""", result: nil)]
}
