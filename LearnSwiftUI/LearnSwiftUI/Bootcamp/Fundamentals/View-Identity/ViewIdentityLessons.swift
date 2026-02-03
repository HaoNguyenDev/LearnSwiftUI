//
//  ViewIdentityLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/1/26.
//

import SwiftUI

struct ViewIdentityLessons {
    static let all: [Lesson] = [
        Lesson(title: "VIEW IDENTITY & DIFFING SYSTEM", code: """
🎯 Goals after completing this section:
You will:
Know why SwiftUI spontaneously resets state
Understand when a view is recreated
No longer fear bugs like:
"State jumps erratically"
"Animation is lost"
"List updates incorrectly"
Understand matchedGeometryEffect from its roots
""", result: nil),
        Lesson(title: "1️⃣ What is View Identity? (CORE CONCEPT)", code: """
❌ Common Mistake
“SwiftUI is declarative, so views are structs → it's okay to recreate them repeatedly”
    ❗ 50% WRONG
SwiftUI DOESN'T care about the View struct

SwiftUI only cares about:
    👉 The identity of the node in the View Tree
    ❗ SwiftUI doesn't update views
    ❗ SwiftUI diffs view trees
    ❗ States are based on identity, not structs
    ❗ 90% of SwiftUI bugs = incorrect identity
✅ Standard Definition
View Identity = how SwiftUI identifies “whether this is the same view” between two body runs

SwiftUI doesn't ask:
    Does this view have the same struct?
SwiftUI asks:
    Does this node in the tree have the same identity?
""", result: nil),
        Lesson(title: "2️⃣ How does SwiftUI Diff Tree work?", code: """
🧠 The right thinking model
Each time the body runs:
    SwiftUI builds a new view tree
    Compares it to the old view tree

Decision:
    Reuse view
    Update view
    Destroy view
    Create a new view
👉 This is called the Diffing Algorithm

🔑 Diff is based on 3 factors
SwiftUI matches nodes based on:
    Type
    Position in hierarchy
    Identity (id)
""", result: nil),
        Lesson(title: "3️⃣ When is a View recreated?", code: """
🔥 A View is recreated when:
    The Type changes
    The order changes
    The Identity changes
    The if/else condition changes branches

Example:

    if isLoggedIn {
        ProfileView()
    } else {
        LoginView()
    }

➡️ LoginView and ProfileView are NEVER the same view
→ State reset is certain
""", result: nil),
        Lesson(title: "4️⃣ id(_:) – A double-edged sword ⚔️", code: """

    Text("Hello")
    .id(user.id)

✅ When used correctly:
    Force SwiftUI to treat this as a new view.
    Reset animation/state intentionally.
❌ When used incorrectly:
    Causes SwiftUI to lose its diff capability.
Causes:
    Continuous view recreation.
    Animation loss.
    Performance drop.
📌 Golden rule:
    ❗ Use id() when you WANT to reset.
    ❌ Do not use it for “temporary bug fixes”.
""", result: nil),
        Lesson(title: "5️⃣ id vs EquatableView (EXTREMELY COMMONLY ASKED IN INTERVIEWS)", code: """
id
    Change identity
    SwiftUI: “This is a different view”

EquatableView
    Keep identity
    Skip update if data doesn't change
    EquatableView(content: MyView(model))

👉 EquatableView = optimizes diff, does NOT reset state
""", result: nil),
        Lesson(title: "6️⃣ @State vs @StateObject vs @ObservedObject (IDENTITY-BINDING)", code: """
🔑 Crucial Principle
    State lives up to the view's identity
Property is bound to the view. When to reset:
    @State View identity When view recreates
    @StateObject View identity (init once) When identity changes
    @ObservedObject External owner Does not maintain its own lifecycle
📌 Common mistake:
@ObservedObject var vm = ViewModel()
➡️ View recreate → vm recreate → state reset 💥
""", result: nil),
        Lesson(title: "", code: """
7️⃣ Why does the state "jump around" in a List?

❌ Code causing a bug

    List(items) { item in
        RowView(item: item)
    }

When:
    items reorder
    insert / delete

➡️ Identity is misaligned → State assigns the wrong row
✅ Correct fix

    List(items, id: .id) { item in
        RowView(item: item)
    }

📌 List = where identity is MOST important
""", result: nil),
        Lesson(title: "8️⃣ What does matchedGeometryEffect work on?", code: """
👉 It's COMPLETELY based on View Identity
    Same ID
    Same Namespace

SwiftUI understands:
    “Ah, this is the same view moving”
If identity changes → animation fails ❌
""", result: nil),
        Lesson(title: "@State & @StateObject with diff view?", code: """
@State:
    @State is storage associated with the View's identity,
    used for local mutable state,
    destroyed when the view identity changes.
    Lives according to view identity.
    Does not have its own lifecycle.
    Not used to own complex objects.

@State private var isOn = false

@StateObject:
    @StateObject is used for the View to OWN an ObservableObject,
    ensuring the object is only initialized once
    during the view identity lifecycle.
    Attached to view identity.
    But the object is not recreated every time the body runs.
    The View is the owner.

@StateObject private var vm = ViewModel()

Summary:
@State stores the value,
@StateObject stores the object,
both live by the view's identity,
but only @StateObject protects the object's lifecycle.

@State is used for small, local UI state within the view.
It is stored according to the view identity and is not reset every time the body runs,
but will be destroyed when the view identity changes.

@StateObject is used when the view owns an ObservableObject.
SwiftUI ensures that the object is initialized only once,
during the lifecycle of the view identity,
and is not recreated every time the body recomputes.

@ObservedObject is used when the ObservableObject is injected from outside.
The view does not own the lifecycle of this object,
it only observes and updates the UI when the object changes.
""", result: nil),
        Lesson(title: "ESSENCE: What is a \"body\" in SwiftUI?", code: """
State / Input / Environment
        ↓
   View invalidated
        ↓
      body()
        ↓
     Diff Tree
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

The body restarts when the view is invalidated,
which occurs when the state, input, or environment that the view depends on changes.
SwiftUI then diffs the view tree to decide whether to update the UI.

""", result: nil),
        Lesson(title: "WHEN WILL MY BODY START RUNNING AGAIN?", code: """
🔥 GROUP 1 — State Changes (MOST IMPORTANT)
1️⃣ @State Changes
@State var count = 0
count += 1
➡️ Invalidate view → body restarts

2️⃣ @Binding Changes
Toggle(isOn: $isOn)
➡️ Parent state changes → child body restarts

3️⃣ @ObservedObject / @StateObject
When @Published emit:
@Published var isLoading = false
➡️ All views currently observing → body restarts

4️⃣ @EnvironmentObject
Object Changes
All subtrees using that object are invalidated
🔥 GROUP 2 — View Input Changes

5️⃣ Property Passed to View Changes
ChildView(title: "A") → ChildView(title: "B")
➡️ ChildView Body Rerun
📌 Even if the view doesn't have @State

6️⃣ View depends on Environment
@Environment(.colorScheme)
@Environment(.locale)
@Environment(.sizeCategory)
➡️ Environment changes → body runs
🔥 GROUP 3 — SwiftUI system trigger

7️⃣ Animation / Transaction
withAnimation {
value += 1
} ➡️ body runs to recompute animation frames

8️⃣ TimelineView / PhaseAnimator
System tick
Time change
Phase change
➡️ body runs periodically

9️⃣ Focus / Keyboard / Scene phase
@FocusState
@Environment(.scenePhase)
➡️ Changes → body runs
🔥 GROUP 4 — View indirect invalidation

🔟 Geometry changes Change
GeometryReader
.onChange(of: geometry.size)
➡️ Size/layout changes → body runs

1️⃣1️⃣ PreferenceKey changes
Child sets preference
Parent reads preference ➡️ Parent body runs again
""", result: nil)
    ]
}
