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
        Lesson(title: "", code: """

""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
        Lesson(title: "", code: """

""", result: nil),
        
    ]
}
