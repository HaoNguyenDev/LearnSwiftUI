//
//  RenderingPerformanceLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 23/1/26.
//

import SwiftUI

struct RenderingPerformanceLesson {
    static let all = [
        Lesson(title: "1️⃣ RENDERING SWIFTUI PIPELINE (EXTREMELY IMPORTANT)", code: """
SwiftUI doesn't "draw the UI" the way you think.

🔁 Standard Pipeline:

    State change
        ↓
    View invalidation
        ↓
    Body recompute
        ↓
    Diff view tree
        ↓
    Layout (if needed)
        ↓
    Drawing (if needed)

📌 Don't always go through the entire pipeline

""", result: nil),
        Lesson(title: "2️⃣ BODY RECOMPUTE ≠ REDRAW ≠ RELAYOUT", code: """
❗ This is where 90% of developers misunderstand

🧩 1. Recompute (Recalculating the body)
Recompute is the process by which SwiftUI re-evaluates the view's body property to create a new view description.
When it happens:
    When @State, @Binding, @ObservedObject, or other property wrappers change
    When the parent view recomputes and passes down new props
    When environment values ​​change

Example:
    struct CounterView: View {
        @State private var count = 0

        var body: some View { // Body is recomputed when count changes
            VStack {
                Text("Count: (count)")
                Button("Increase") { count += 1 }
            }
        }
    }

    ```## Comparing all 3 concepts```
    User changes @State
            ↓
    RECOMPUTE (calculates new body)
            ↓
    SwiftUI diff old vs new body
            ↓
┌──────────────────┬────────────────┐
↓                  ↓                ↓
DO NOT CHANGE   RELAYOUT          REDRAW
(skip) (recalculate position) (redraw color)

➡️ body reruns
❌ Not necessarily a redraw

🧩 2. Relayout
Relayout is the process of recalculating the size and position of a view and its child views.
When it happens:
    When frame, padding, or spacing changes
    When content changes size (text gets longer, new views are added)
    When orientation changes
    When constraints or alignment change

Example:
    @State private var padding: CGFloat = 10

    Text("Hello")
    .padding(padding) // Causes relayout when padding changes

➡️ SwiftUI has to recalculate the layout tree

🧩 3. Redraw
Redraw is the process of redrawing the appearance of a view without changing its size or position.
When it happens:
    When color, opacity, or effect properties change
    When text content changes but does not affect the layout
    When animation only changes visual properties

Example:
    @State private var opacity: Double = 1.0
    Text("Hello")
    .opacity(opacity) // Redraw only when opacity changes

➡️ GPU redraw

🧠 COMPARISON TABLE
Step-by-step details
Step    Recompute               Relayout                Redraw
When    State changes           Size/position changes   Visual properties change 
Cost    Medium                  High                    Low 
Result  New view description    New size & position     New pixels 
Impact  Current view only       Hierarchy               Both drawing layers only

Important Note:
SwiftUI automatically optimizes this process, but understanding the differences will help you:

Avoid unnecessary relayouts by using .drawingGroup() or splitting the view into smaller parts
Prioritize animation for properties that only need redrawing for better performance
Use GeometryReader carefully as it can cause many relayouts

In summary:

Recompute: Calculates the new body (logic level)
Relayout: Calculates the position/size (layout level)
Redraw: Draws pixels (rendering level)

The usual order is: Recompute → Relayout (if needed) → Redraw (if needed)
""", result: nil),
        Lesson(title: "Example", code: """
struct Example: View { 
    @State private var count = 0 
    @State private var color: Color = .blue 
    @State private var size: CGFloat = 100 

    var body: some View { 
        // Body RECOMPUTE every time any @State changes 
        VStack { 
            Text("Count: (count)") // RECOMPUTE → REDRAW (new text) 
            .foregroundColor(color) // RECOMPUTE → REDRAW (new color) 
            .frame(width: size) // RECOMPUTE → RELAYOUT → REDRAW 

            Button("Change color") { 
                color = .red // → RECOMPUTE → REDRAW 
            } 

            Button("Change size") { 
                size = 200 // → RECOMPUTE → RELAYOUT → REDRAW
            }
        }
    }
}

Reduce Recompute:
// ❌ Bad: entire view recompute
struct BadExample: View { 
    @State private var count = 0 
    @State private var unrelatedText = "" 

    var body: some View { 
        VStack { 
            Text("(count)") 
            TextField("Input", text: $unrelatedText) 
        } 
    }
}

// ✅ Better: split into sub-views
struct GoodExample: View { 
    @State private var count = 0 
    @State private var unrelatedText = "" 

    var body: some View { 
        VStack { 
            CounterView(count: count) 
            InputView(text: $unrelatedText) 
        } 
    }
}
""", result: nil),
        Lesson(title: "3️⃣ VIEW INVALIDATION — CORE PERFORMANCE", code: """
SwiftUI invalidates views instead of updating the UI immediately.
When is a view invalidated?

    The state it uses changes.
    The environment changes.
    The preference key changes.

➡️ SwiftUI marks the view as dirty.
📌 Dirty ≠ redraw.
Dirty = “the next diff needs to be re-examined.”
""", result: nil),
        Lesson(title: "4️⃣ EQUIATABLEVIEW — OPTIMIZE DIFF", code: """
🧠 What does EquatableView do?
It tells SwiftUI:
    “If input is the same → skip body”

❌ Don't use EquatableView

    RowView(model: model)

body reruns
deep diff

✅ Use EquatableView

EquatableView {
    RowView(model: model)
}

Or:

struct RowView: View, Equatable {
    static func == (...) -> Bool { ... }
} 

➡️ Skip body
➡️ Skip diff subtree
📌 Only use when body is heavy
""", result: {
    AnyView(ResultBlockView(content: {
        DemoEquatableView(stringData: "Hello SwiftUI!")
            .equatable()
    }))
}),
        Lesson(title: "5️⃣ PERFORMANCE TRAPS (COMMON)", code: """
❌ Trap 1 — Deeply nested GeometryReader
    Causes continuous relayouts
    Difficult to predict
👉 Use sparingly

❌ Trap 2 — Abuse of PreferenceKey
    Trigger parent invalidates
    Easily creates feedback loops

❌ Trap 3 — Heavy Modifiers in Lists
    .shadow()
    .blur()
    .mask() 

➡️ Offscreen rendering → Expensive GPU
""", result: nil),
        Lesson(title: "6️⃣ .drawingGroup() — A DOUBLE-EDGED SWORD", code: """
What is drawingGroup()?
drawingGroup() is a modifier in SwiftUI that optimizes rendering by transferring view drawing to the Metal rendering engine.
drawingGroup() instructs SwiftUI to render the entire view hierarchy as a single texture/image
instead of rendering each layer individually.

🧠 What does it do?
Render subtrees into the offscreen buffer
Cache them

How it works

// ❌ Don't use drawingGroup

    VStack {
        ForEach(0..<100) { i in
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
        }
    }

// SwiftUI renders 100 individual circles → slow

// ✅ Use drawingGroup

    VStack {
        ForEach(0..<100) { i in
            Circle()
            .fill(Color.blue)
            .frame(width: 50, height: 50)
        }
    }
    .drawingGroup()

// SwiftUI renders as one image → faster

✅ When to use it:
    Many similar shapes/views
    Complex vector drawing
    Animation transform

❌ When not to use it:
    Text
    Large lists
    Content that changes constantly

In summary,
    drawingGroup() is not the optimal tool for every situation. Use it when:
    You have many shapes/paths to draw
    Animation with many elements
    You have measured and seen performance improvements

Profile your app in Instruments before deciding to use it!
""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
    ]
}
