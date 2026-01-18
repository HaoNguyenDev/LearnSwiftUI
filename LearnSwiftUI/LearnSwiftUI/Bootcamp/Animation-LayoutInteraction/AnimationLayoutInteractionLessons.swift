//
//  AnimationLayoutInteractionLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

struct AnimationLayoutInteractionLessons {
    static let all: [Lesson] = [
        Lesson(title: "1️⃣ The most important mental model", code: """
🔑 SwiftUI animateS DATA CHANGES, not views

Consequences:
    When data changes → body recompute
    SwiftUI compares the layout before and after
    If there is animation → interpolates the layout
📌 Therefore:
    Layout changes can be animated
    But it's not always recommended
""", result: nil),
        
        Lesson(title: "2️⃣ Implicit animation & layout", code: """
Classic Example:

    VStack {
        if expanded {
            Text("Expanded")
        }
    }
    .animation(.easeInOut, value: expanded)

What is animating?
    ❌ Not Text
    ❌ Not VStack
    ✅ Change in layout tree (insert/remove view)
👉 SwiftUI:
    Calculate old layout
    Calculate new layout
    Animate from old layout → new layout
""", result: {
    AnyView(
        ResultBlockView(content: {
            ClassicAnimation()
    }))
}),
        Lesson(title: "3️⃣ Why does the layout \"jump\" during animation?", code: """
Example:

    VStack {
        Text("Title")
        if showDetail {
            Text("Detail")
        }
    }

When showDetail = true
VStack increases height
The views below are pushed down
If there is animation:
👉 the entire transition is animated
📌 This is correct behavior, not a bug.
""", result: {
    AnyView(ResultBlockView(content: {
        JumpAnimationBehaviorExample()
    }))
}),
        Lesson(title: "4️⃣ Implicit vs. Explicit Animation (Extremely Important)", code: """
Implicit Animation

    .animation(.spring(), value: isOn)

Attached to the view
All changes related to isOn are animated
Easy to over-animate

Explicit Animation

    withAnimation(.spring()) {
        isOn.toggle()
    }

Only animates that logic block
Easy to control
Preferred for use in production
""", result: {
    AnyView(ResultBlockView(content: {
        ImplicitvsExplicitAnimationExample()
    }))
}),
        Lesson(title: "5️⃣ .transition vs .animation", code: """

.transition
    Used for inserting/removing views
Only effective when:
    the view actually appears/disappears

    Text("Detail")
    .transition(.move(edge: .bottom))

.animation
    Animate state change
    Does not determine how the view enters/exits

📌 Many developers confuse these two.
""", result: {
    AnyView(ResultBlockView(content: {
        TransitionVsAnimationExample()
    }))
}),
        Lesson(title: "6️⃣ Geometry change vs transform (extremely important)", code: """

❌ Animate geometry (easy to jerk)

    .frame(height: expanded ? 300 : 100)

👉 Layout recalculation
👉 Sibling affected
👉 Easy to jerk

✅ Animate transform (smooth)

    .scaleEffect(expanded ? 1.2 : 1.0)

👉 Does not affect layout
👉 Just a transform
📌 Rule Senior:
    Animate transform > animate layout
""", result: {
    AnyView(ResultBlockView(content: {
        GeometryChangeVsTransformExample()
    }))
}),
        Lesson(title: "Performance rules (MUST REMEMBER)", code: """
❌ Avoid:
    Animate frames in lists
    Animate layouts in lazy items
    Animate multiple views at once
    GeometryReader + animation loop
✅ Do:
    Animate opacity / scale / offset
    Explicit animation
    transaction { $0.animation = nil } when needed
""", result: nil),
        Lesson(title: "Transaction — Disable controlled animation", code: """

    Text("Title")
        .transaction { tx in
            tx.animation = nil
        }

👉 Block animation propagation
👉 Very useful in lists
""", result: nil),
        
        Lesson(title: "Excellent interview questions!", code: """

❓ Why does animation make the layout "jump"?
✅ Because SwiftUI animates layout changes, not views.

❓ When should you animate a frame?
❌ Almost never.

❓ How to prevent animation from spilling over into siblings?
✅ Use explicit animation or transactions.
""", result: nil),
        Lesson(title: "Mental checklist before animating", code: """
Before writing an animation, ask yourself:
	1️⃣ Am I animating data or layout?
	2️⃣ Will any siblings be affected?
	3️⃣ Am I animating in Lazy mode?
	4️⃣ Should I use transforms instead of frames?
	5️⃣ Is animation necessary?
""", result: nil),
        
    ]
}
