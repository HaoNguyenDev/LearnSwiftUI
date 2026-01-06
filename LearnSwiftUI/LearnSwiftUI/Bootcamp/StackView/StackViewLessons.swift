//
//  StackViewLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/1/26.
//

import SwiftUI

enum StackViewLessons {
    static let all: [Lesson] = [
        Lesson(title: "Truly nature of StackView", code: """
1️⃣ Important Fact
Stacks do NOT have their own size.
Stacks are just containers for organizing children.

❌ Common mistake:
VStack defaults to full screen.
✅ Correct nature:
VStack only holds content, unless the parent forces a specific size.

2️⃣ Layout Cycle in Stack (Applying Lesson 1)

Example:
    VStack {
        Text("Hello")
            .background(.green)
        Text("SwiftUI")
            .background(.orange)
    }
    .background(.gray)

🔁 The layout works as follows:
1️⃣ Parent (body root) proposes the size
2️⃣ VStack passes that proposal to each child
3️⃣ Each Text selects its own size
4️⃣ VStack:
    Adds the sizes of the children (main axis)
    Gets the maximum size (secondary axis)
📌 VStack size =
    Height = total height of children
    Width = maximum width of children
""", result: {
    AnyView(
        ResultBlockView(content: {
            VStack {
                Text("Hello")
                    .background(.green)
                Text("SwiftUI")
                    .background(.orange)
            }
            .background(.gray)
        })
    )
}),
        
        Lesson(title: "Main Axis & Cross Axis", code: """
3️⃣ Main shaft and auxiliary shaft (extremely important)

| Stack  | Main Axis  | Cross Axis |
| ------ | ---------- | ---------- |
| VStack | Vertical   | Horizontal |
| HStack | Horizontal | Vertical   |
| ZStack | None       | None       |

👉 Only the main axis "divides the space"
""", result: nil),
        
        Lesson(title: "Spacer", code: """
❓ What is a Spacer?
A Spacer is a View that can expand infinitely along its main axis.

    HStack {
        Text("Left")
        Spacer()
        Text("Right")
    }

🔍 What happens?
Spacer receives the proposal
Spacer selects the largest possible size
Text retains its intrinsic size
📌 Spacer consumes the remaining space

""", result: {
    AnyView(
        ResultBlockView(content: {
            HStack {
                Text("Left")
                    .background(.green)
                Spacer()
                    .background(.blue)
                Text("Right")
                    .background(.red)
            }
        })
    )
}),
        Lesson(title: "", code: """
❓ What about multiple Spacers?

    HStack {
        Text("A")
        Spacer()
        Spacer()
        Text("B")
    } 
👉 The extra space is divided equally
(because the layoutPriority = 0)

""", result: {
    AnyView(ResultBlockView(content: {
        HStack {
            Text("A")
            Spacer()
            Spacer()
            Text("B")
        }
    }))
}),
        Lesson(title: "Spacer vs frame(maxWidth: .infinity)", code: """
Spacer vs frame(maxWidth: .infinity)
🔥 Excellent interview questions

Text("Hello")
    .frame(maxWidth: .infinity)

❌ This is NOT Spacer

| Spacer               | frame(.infinity)  |
| -------------------- | ----------------- |
| Joins layout         | Is a container    |
| Divides space        | Does not divide   |
| Only works in Stack  | Works everywhere  |

👉 Spacers change the layout behavior of the stack.
""", result: nil),
        
        Lesson(title: "Alignment in Stack", code: """
Alignment in Stack (Understanding Correctly)

    VStack(alignment: .leading) {
        Text("Short")
        Text("Very very long text")
    } 

⚠️ Alignment:
    Does NOT affect size
    Only affects placement
📌 Here's why:
    .frame(alignment:)
does not stretch the view

""", result: nil),
        
        Lesson(title: "ZStack", code: """
ZStack — no partitioning

    ZStack {
        Color.red
        Text("Top")
    }
ZStack suggests a size for all children
Child stacking
ZStack size = maximum child size
📌 ZStack does not shrink, does not expand
""", result: {
    AnyView(ResultBlockView(content: {
        ZStack {
            Color.red
            Text("Top")
        }
    }))
}),
        Lesson(title: "Interview traps", code: """
Why does the Spacer in VStack not work?

    VStack {
        Text("Top")
        Spacer()
    } 
👉 Only works if:
VStack has extra height

❌ If VStack wraps content → Spacer = 0

✅ To make the Spacer work:
    VStack {
        Text("Top")
        Spacer()
    }
    .frame(maxHeight: .infinity)

Spacer only expands when its parent provides extra space on the main axis.
In body root, VStack usually receives a full-screen proposal,
so Spacer continues to function even without setting a frame.
""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            Text("Top")
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(.gray)
    }))
})
    ]
}
