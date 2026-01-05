//
//  SwiftUILayoutSystemBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/1/26.
//

import SwiftUI

struct SwiftUILayoutSystemBootcamp: View {
    var body: some View {
        ScrollView {
            CodePreviewContainer(title: "SwiftUI Layout System", code: """
    Parent Proposes → Child Chooses → Parent Places

    1️⃣ Overview: SwiftUI layouts are NOT the same as Auto Layout

    In UIKit:
        Constraints determine size
        A "mathematical problem-solving" system

    In SwiftUI:
        No constraints
        Layout is a dialogue between Parent and Child

    2️⃣ 3 Immutable Steps of SwiftUI Layout
        🔁 Step 1 — Parent proposes size
        Parent proposes a size for the child:
        “Son, this is the space you can use.”

    The proposal can be:
        Specific: width = 100
        Unlimited: .infinity
        Undefined: nil
    ⚠️ A proposal is not a command
    
    🔁 Step 2 — Child chooses size
    Child:
        Look at the proposal
        Based on intrinsic content size
        Based on modifiers (frame, fixedSize, layoutPriority)
        Decide on their own size
    👉 Child has the right to reject the proposal
    
    🔁 Step 3 — Parent places child
        After the child chooses the size:
        Parent places the child in position
    Based on:
        alignment
        stack direction
        spacing
    """, resultView: AnyView(ResultBlockView(content: {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                }
            })))
            
            CodePreviewContainer(title: "Visual example", code: """
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
""", resultView: AnyView(ResultBlockView(content: {
                VStack {
                    Text("Hello")
                        .background(Color.red)

                    Text("SwiftUI")
                        .background(Color.blue)
                }
                .background(Color.green)
            })))

            
            CodePreviewContainer(title: "Parent suggests .infinity", code: """
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
""", resultView: AnyView(ResultBlockView(content: {
                Text("Hello SwiftUI")
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
            })))
        } /// ScrollView
    }
}

#Preview {
    SwiftUILayoutSystemBootcamp()
}
