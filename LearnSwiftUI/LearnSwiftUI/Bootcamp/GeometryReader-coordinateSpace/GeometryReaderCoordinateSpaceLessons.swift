//
//  GeometryReaderCoordinateSpaceLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

struct GeometryReaderCoordinateSpaceLessons {
    static let all: [Lesson] = [
        Lesson(title: "The opening statement (to remember):", code: """
❗ GeometryReader is NOT a size picker tool.
❗ It is a special layout container.
If you remember these two sentences, you can avoid 80% of mistakes.

What is a GeometryReader (correct definition)?
A GeometryReader is a View that always occupies the entire proposal given to it by the parent,
and provides the geometric information of that space to the child.

🔑 A key (and very memorable) statement:
GeometryReader doesn't measure views —
it measures the space it occupies.
""", result: nil),
        
        Lesson(title: "Common mistakes (many developers make)", code: """
	VStack {
	    GeometryReader { geo in
	        Text("Hello")
	            .frame(width: geo.size.width)
	            .background(.green)
	    }
	}
	.background(.gray)
	.frame(width: 100, height: 80)

❌ Misconceptions:
    GeometryReader only wraps text
✅ Reality:
    GeometryReader occupies the entire height of the VStack
    The VStack is stretched
    The layout tree is altered
📌 GeometryReader is always greedy

""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            GeometryReader { geo in
                Text("Hello")
                    .frame(width: geo.size.width)
                    .background(.green)
            }
        }
        .background(.gray)
        .frame(width: 100, height: 80)
    }))
}),
        Lesson(title: "Layout cycle with GeometryReader", code: """
Layout Cycle with GeometryReader
🔁 Parent → GeometryReader
    Parent suggests size (usually full)
    GeometryReader receives the entire proposal
    GeometryReader does not handle content
🔁 GeometryReader → Child
    GeometryReader suggests full size for child
    Child layout inside does not affect GeometryReader's size
📌 GeometryReader blocks layout propagation
""", result: nil),
        
        Lesson(title: "Why does GeometryReader often \"ruin the layout\"?", code: """
    VStack {
        Text("Top")
        GeometryReader { geo in
            Color.blue
        }
        Text("Bottom")
    }

👉 GeometryReader:
    Taking up all the space between
    Text("Bottom") is pushed down
❗ This is not a bug
👉 This is standard behavior
""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            Text("Top")
                .background(.green)
            GeometryReader { geo in
                Color.blue
            }
            Text("Bottom")
                .background(.orange)
        }
    }))
}),
        Lesson(title: "The golden rule when using GeometryReader", code: """
🔑 Do not place the GeometryReader directly in the stack without checking the size.
""", result: nil),
        
        Lesson(title: "How to use GeometryReader correctly", code: """
✅ Method 1 — Wrap in a fixed frame

	GeometryReader { geo in
	    Text("Hello")
	        .background(.green)
	}
	.frame(height: 100)
	.background(.gray)

👉 GeometryReader only takes up height 100.
""", result: {
    AnyView(ResultBlockView(content: {
        GeometryReader { geo in
            Text("Hello")
                .background(.green)
        }
        .frame(height: 100)
        .background(.gray)
    }))
}),
        Lesson(title: "", code: """
✅ Method 2 — Use an overlay/background (HIGHLY RECOMMENDED)
        VStack {
            Text("Hello")
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                print(geo.size)
                            }
                    }
                )
            
            Text("Hello")
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                print(geo.size)
                            }
                    }
                )
        }
👉 Don't disrupt the layout
👉 Measure the text to the correct size
🔥 This is how Seniors use it.
""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            Text("Hello")
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                print(geo.size)
                            }
                    }
                )
            
            Text("Hello")
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                print(geo.size)
                            }
                    }
                )
        }
    }))
}),
        Lesson(title: "What is coordinateSpace?", code: """
coordinateSpace defines the coordinate system for measuring position and frame.

Three types:
    .local
    .global
    .named("MySpace")

""", result: nil),
        Lesson(title: "Example: local vs global", code: """
    GeometryReader { geo in
        Text("Hello")
            .onAppear {
                print("local:", geo.frame(in: .local))
                print("global:", geo.frame(in: .global))
            }
    }

📌 .local → in GeometryReader
📌 .global → full screen
""", result: {
    AnyView(ResultBlockView(content: {
        GeometryReader { geo in
            Text("Hello")
                .onAppear {
                    print("Hello local:", geo.frame(in: .local))
                    print("Hello global:", geo.frame(in: .global))
                }
        }
    }))
}),
        Lesson(title: "Named coordinatespace (very important)", code: """
    ScrollView {
        VStack {
            Text("Item")
        }
    }
    .coordinateSpace(name: "scroll")

    GeometryReader { geo in
        let y = geo.frame(in: .named("scroll")).minY
        Text("(y)")
    }

👉 Used for:
    Sticky header
    Parallax
    Scroll offset tracking
""", result: {
    AnyView(
        ResultBlockView(content: {
            ScrollView {
                VStack {
                    Text("Item")
                }
            }
            .coordinateSpace(name: "scroll")

            GeometryReader { geo in
                let y = geo.frame(in: .named("scroll")).minY
                Text("\(y)")
            }

        })
    )
}),
        Lesson(title: "When should you NOT use GeometryReader?", code: """
❌ To center
❌ To change the spacer
❌ For basic layout
❌ When you don't understand the proposal
""", result: nil),
        
        Lesson(title: "Debug GeometryReader", code: """
Always add:
    .background(Color.red.opacity(0.2))
""", result: nil),
        
        Lesson(title: "Interview trap", code: """
Interview Trap #1
❓ Does GeometryReader have intrinsic size?
❌ No
✅ It always takes up the proposal space

Interview Trap #2
❓ Why is GeometryReader often placed in ZStack?
✅ Because:
ZStack allows overlay
GeometryReader does not affect the flow
""", result: nil)
    ]
}
