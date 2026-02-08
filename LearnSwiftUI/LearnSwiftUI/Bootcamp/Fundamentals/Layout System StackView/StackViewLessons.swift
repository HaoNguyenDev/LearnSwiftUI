//
//  StackViewLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/1/26.
//

import SwiftUI

enum StackViewLessons {
    static let all: [Lesson] = [
        Lesson(title: "Understanding Layout Process in SwiftUI", code: """
SwiftUI layouts work in 3 steps:

1.Parent suggests a size for the child
2.Child chooses its size (which may differ from the suggestion)
3.Parent places the child in the appropriate position

struct LayoutProcessDemo: View {
    var body: some View {
        VStack {
            Text("Parent suggested the entire width")
                .background(Color.blue)
            Text("Child only takes the necessary space")
                .background(Color.green)
        }
        .background(Color.gray.opacity(0.2))
    }
}
""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            Text("Parent suggested the entire width")
                .background(Color.blue)
            Text("Child only takes the necessary space")
                .background(Color.green)
        }
        .background(Color.gray.opacity(0.2))
    }))
}),
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
        Lesson(title: "Alignment Options", code: """
struct HStackAlignment: View {
    var body: some View {
        VStack(spacing: 20) {
            // Top alignment
            HStack(alignment: .top) {
                Text("Top")
                    .font(.largeTitle)
                Text("aligned")
                    .font(.caption)
            }
            
            // Center (default)
            HStack(alignment: .center) {
                Text("Center")
                    .font(.largeTitle)
                Text("aligned")
                    .font(.caption)
            }
            
            // Bottom alignment
            HStack(alignment: .bottom) {
                Text("Bottom")
                    .font(.largeTitle)
                Text("aligned")
                    .font(.caption)
            }
        }
    }
}
""", result: {
    AnyView(ResultBlockView(content: {
        HStackAlignment()
    }))
}),
        Lesson(title: "ZStack - Overlay Stack", code: """
ZStack — no partitioning

ZStack {
  Rectangle()
      .fill(Color.blue)
      .frame(width: 200, height: 200)
  
  Rectangle()
      .fill(Color.green)
      .frame(width: 150, height: 150)
  
  Text("On Top")
      .foregroundColor(.white)
      .font(.title)
}

ZStack suggests a size for all children
Child stacking
ZStack size = maximum child size
📌 ZStack does not shrink, does not expand
""", result: {
    AnyView(ResultBlockView(content: {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 200, height: 200)
            
            Rectangle()
                .fill(Color.green)
                .frame(width: 150, height: 150)
            
            Text("On Top")
                .foregroundColor(.white)
                .font(.title)
        }
    }))
}),
        Lesson(title: "Alignment trong ZStack", code: """
ZStack(alignment: .topLeading) {
    Rectangle()
        .fill(Color.blue.opacity(0.3))
        .frame(width: 300, height: 300)
    
    Text("Top Leading")
        .padding()
        .background(Color.white)
}
""", result: {
    AnyView(ResultBlockView(content: {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(Color.blue.opacity(0.3))
                .frame(width: 300, height: 300)
            
            Text("Top Leading")
                .padding()
                .background(Color.white)
        }
    }))
}),
        Lesson(title: "ZStack cho Background & Overlay", code: """
ZStack {
  // Background layer
  LinearGradient(
      gradient: Gradient(colors: [.blue, .red]),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
  )
  .ignoresSafeArea()
  
  // Content layer
  VStack(spacing: 20) {
      Text("Welcome")
          .font(.largeTitle)
          .fontWeight(.bold)
      
      Text("ZStack cho layering")
          .font(.subheadline)
  }
  .foregroundColor(.white)
}
""", result: {
    AnyView(ResultBlockView(content: {
        ZStack {
            // Background layer
            LinearGradient(
                gradient: Gradient(colors: [.blue, .red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Content layer
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("ZStack cho layering")
                    .font(.subheadline)
            }
            .foregroundColor(.white)
        }
    }))
}),
        Lesson(title: "Combine StackView", code: """
struct CombineStackViewExample: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header with ZStack
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 120)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    )
                    .offset(y: 40)
            }
            
            // Content with VStack
            VStack(spacing: 12) {
                Text("Hao Nguyen")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 50)
                
                Text("iOS Developer")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Stats with HStack
                HStack(spacing: 40) {
                    VStack {
                        Text("1,234")
                            .font(.headline)
                        Text("Followers")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    VStack {
                        Text("567")
                            .font(.headline)
                        Text("Following")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    VStack {
                        Text("89")
                            .font(.headline)
                        Text("Posts")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}
""", result: {
            AnyView(ResultBlockView(content: {
                CombineStackViewExample()
            }))
        }),
        Lesson(title: "Example", code: """
ProductCardStackExample()
""", result: {
    AnyView(ResultBlockView(content: {
        ProductCardStackExample()
    }))
}),
        Lesson(title: "Spacer & Divider", code: nil, result: nil),
        Lesson(title: "Spacer", code: """
Spacer in Stacks

struct SpacerDemo: View {
    var body: some View {
        VStack {
            HStack {
                Text("Left")
                Spacer() // Push to the sides
                Text("Right")
            }
            
            Spacer() // Push to the bottom
            
            HStack {
                Spacer()
                Text("Center")
                Spacer()
            }
        }
        .padding()
    }
}
""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            HStack {
                Text("Left")
                Spacer() // Push to the sides
                Text("Right")
            }
            
            Spacer() // Push to the bottom
            
            HStack {
                Spacer()
                Text("Center")
                Spacer()
            }
        }
        .padding()
    }))
}),
        Lesson(title: "Divider", code: """
struct DividerDemo: View {
    var body: some View {
        VStack {
            Text("Section 1")
            Divider() // Horizontal line
            Text("Section 2")
            
            HStack {
                Text("Left")
                Divider() // Vertical line trong HStack
                Text("Right")
            }
            .frame(height: 50)
        }
        .padding()
    }
}
""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            Text("Section 1")
            Divider() // Horizontal line
            Text("Section 2")
            
            HStack {
                Text("Left")
                Divider() // Vertical line trong HStack
                Text("Right")
            }
            .frame(height: 50)
        }
        .padding()
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
