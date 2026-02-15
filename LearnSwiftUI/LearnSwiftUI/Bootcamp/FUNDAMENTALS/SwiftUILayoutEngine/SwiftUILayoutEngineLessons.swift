//
//  SwiftUILayoutEngineLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/1/26.
//

import SwiftUI

enum SwiftUILayoutEngineLessons {
    static let all: [Lesson] = [
        Lesson(title: "SWIFTUI LAYOUT ENGINE",
               code: """
    
    Before writing any layout code, you must understand:
    ❗ SwiftUI doesn't layout views based on a "place view wherever you want" approach.
    ❗ SwiftUI layout views using a "proposal" system.
    
    Parent Proposes → Child Chooses → Parent Places
    
    1️⃣ Overview: SwiftUI layouts are NOT the same as Auto Layout
    
    In UIKit:
        Constraints determine size
        A "mathematical problem-solving" system
    
    In SwiftUI:
        No constraints
        Layout is a dialogue between Parent and Child
    
    2️⃣ SwiftUI Layout works across 3 phases.
    
    🔁 Step 1️⃣ Parent proposes size
        Parent says to child:
        “I have space X, how much do you want?”
    
        Examples:
        VStack → proposes a fixed width
        ScrollView → proposes infinite height
        GeometryReader → proposes full size
    
    The proposal can be:
        Specific: width = 100
        Unlimited: .infinity
        Undefined: nil
    ⚠️ A proposal is not a command
    
    🔁 Step 2️⃣ — Child chooses its size
    Child:
        Look at the proposal
        Based on intrinsic content size
        Based on modifiers (frame, fixedSize, layoutPriority)
        Decide on their own size
        Child is NOT obligated to accept the size suggested by the parent.
    
    Example:
        Text("Hi") → only takes the size that fits the text
        Spacer() → expands to the maximum
        .frame(width: 200) → overrides the suggestion
    
    🔁 Step 3️⃣ — Parent places child
        After the child chooses the size:
        Parent places the child in position
    Based on:
        where to place the child
        left/center/right
        alignment
        stack direction
        spacing
    
    🔁 Step 4️⃣ — Rendering
        SwiftUI creates render tree
        Sends draw commands to GPU
        Only changed parts are redrawn
    
    View Tree vs Render Tree
    
    // VIEW TREE (logical)
    VStack {
        Text("Title")
        HStack {
            Image("icon")
            Text("Subtitle")
        }
    }

    // RENDER TREE (actual drawing)
    [
        DrawText("Title", at: CGPoint(x: 100, y: 50)),
        DrawImage("icon", at: CGPoint(x: 100, y: 100)),
        DrawText("Subtitle", at: CGPoint(x: 150, y: 100))
    ]
    
    📌 Senior Interview
    Is SwiftUI layout a push or pull system?
    
    ✅ Pull-based (child chooses size)
    👉 Child has the right to reject the proposal
    """,
               result: nil),
        Lesson(title: "Visual example",
               code: """
3️⃣ Visual Examples (Code + Analysis)
Example 1: VStack + Text

    VStack {
        Text("Hello")
        .background(Color.red)

        Text("SwiftUI")
        .background(Color.blue)
    }
    .background(Color.green)

🔍 Layout Analysis
VStack does not have its own size
VStack suggests a size for each Text element
Text is sized to fit the content
VStack arranges Text along the vertical axis
📌 VStack size = sum of the sizes of the children

4️⃣ Interview Trap #1
Why isn't VStack in full screen?

❌ Misconception:
    VStack defaults to full screen.

✅ True nature:
    VStack only holds content
    Parent (usually body root) does not force size

👉 To use full size:
    VStack {
        Text("Hello")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)    
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       VStack {
                           Text("Hello")
                               .background(Color.red)
                           
                           Text("SwiftUI")
                               .background(Color.blue)
                       }
                       .background(Color.green)
                   }))
               }),
        Lesson(title: "Parent suggests .infinity",
               code: """
5️⃣ Example 2 — Parent suggests .infinity

    Text("Hello SwiftUI")
        .frame(maxWidth: .infinity)
        .background(Color.red)

❓ Does the text have full width?

👉 YES, but:
    frame is `the new parent`
    Frame suggests .infinity for the text
    Text chooses the content size
    Frame expands, text does not

📌 This is why the text doesn't automatically expand

6️⃣ Interview Trap #2
❓ Why doesn't the text expand to full size even with maxWidth: .infinity?
    Senior's Answer:
        Because text always chooses intrinsic content size,
    while the frame is just an expanded container.
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Hello SwiftUI")
                           .frame(maxWidth: .infinity)
                           .background(Color.red)
                   }))
               }),
        Lesson(title: "Debugging Layouts", code: """
7️⃣ Debugging Layouts (Required Skill)

    How to truly understand a layout:

    Text("Hello")
        .background(Color.red)
        .frame(maxWidth: .infinity)
        .background(Color.blue)

    🔴 Red = Text
    🔵 Blue = Frame
👉 You should always debug this way
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Hello")
                           .background(Color.red)
                           .frame(maxWidth: .infinity)
                           .background(Color.blue)
                   }))
               }),
        Lesson(title: "Summary",
               code: """
                8️⃣ Summary (must be memorized)
                
                ✅ SwiftUI doesn't force layouts
                
                ✅ Parents only suggest layouts
                
                ✅ Children choose their own size
                
                ✅ Parents set the position
                """,
               result: nil),
        Lesson(title: "Sample Interview Questions",
               code: """
9️⃣ Sample Interview Questions
Q: In SwiftUI, who decides the final size of View
A (Senior): The Child decides the size based on parent's proposal

Q: Does the frame force the child to change size
A: No, the frame is a container; it doesn't force intrinsic size.
""", result: nil),
        Lesson(title: "Sample Interview Questions", code: """
HStack {
    Text("Short")
        .background(Color.red)
        
    Text("This is a very very long text")
        .background(Color.blue)
}
.frame(width: 200)
.background(Color.green)
        
        
1.Which view shrinks first?
2.Why?
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       HStack {
                           Text("Short")
                               .background(Color.red)
                           
                           Text("This is a very very long text")
                               .background(Color.blue)
                       }
                       .frame(width: 200)
                       .background(Color.green)
                   }))
               }),
        Lesson(title: "Answer",
               code: """
🧠 Explanation of the true nature (very important)

1️⃣ Both Texts have:
layoutPriority = 0 (default)
→ SwiftUI does not use priority to decide

2️⃣ When space is limited (frame = 200)
SwiftUI uses intrinsic content size + compression capability

Text("Short")
Intrinsic size is small
Cannot shrink much further

Text("This is a very very long text")
Intrinsic size is large
Has a higher chance of shrinking/truncate

👉 SwiftUI prioritizes:
Keeping the "less scalable" view stable, sacrificing the "scalable" view first
""",
               result: nil),
    ]
}
