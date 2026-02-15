//
//  GeometryReaderCoordinateSpaceLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

struct GeometryReaderCoordinateSpaceLessons {
    static let all: [Lesson] = [
        Lesson(title: "📐 GEOMETRYREADER — UNDERSTANDING FROM THE ROOT", code: """
What exactly is a Geometry Reader?
Standard Definition (Senior):

    A GeometryReader is a View that always occupies the entire proposal given to it by its parent,
and provides the child with geometric information (size, position) of that space.

📌 It doesn't measure the child
📌 It measures the space it occupies

With GeometryReader:
🔁 Parent → GeometryReader
    Parent submits a proposal (usually very large)
    GeometryReader does NOT reject it
    It always selects the entire proposal
👉 GeometryReader has no intrinsic size

🔁 GeometryReader → Child
    GeometryReader outputs a proposal with its own size.
    The inner child layout does not affect the child layout.
👉 Here's why GeometryReader:
    Blocks layout propagation.
    Makes layouts "rigid".

What GeometryReader IS NOT (clarifying misunderstandings)
❌ Not a layout tool
    Not used for centering
    Not used to replace spacers
    Not used to stretch views
❌ Not a child measurement tool
Example code: 

    GeometryReader { geo in
        Text("Hello")
    } 

👉 geo.size is NOT the size of the text
👉 It is the size of GeometryReader only

GeometryReader should NEVER be used for:
    ❌ Fixing layouts just to "get it done"
    ❌ Replacing Spacers
    ❌ Creating basic responsive layouts
    ❌ Placing within Lazy Items 
    ❌ Placing directly within ScrollView

If you see GeometryReader in:
    cell
    row
    LazyVStack item
→ 🚨 review it immediately
""", result: nil),
        
        Lesson(title: "WHAT IS THE PURPOSE OF A GEOMETRY READER?", code: """
👉 The sole, core purpose:
A GEOMETRY READER is designed to let the View KNOW the space it occupies.
Specifically:
Dimensions (width / height)
Position (x / y)
Position relationship relative to a defined coordinate system
📌 A GEOMETRY READER is not a layout tool
📌 It is a measurement / observation tool

The problem that SwiftUI does NOT solve by default:
SwiftUI layouts intentionally hide size and position information:

        Text("Hello")

👉 You don't know:
    How wide is it?
    Where is it on the screen?
    How much has it been scrolled up?
    SwiftUI does this to:
    Avoid layouts that depend on circles
    Keep the layout declarative
📌 GeometryReader was created to break this "veil," in a controlled manner.
""", result: nil),
        
        Lesson(title: "How to use GeometryReader correctly in ScrollView", code: """

✅ Use background / overlay

    Text("Item") 
    .background( 
        GeometryReader { geo in 
            Color.clear 
        } 
    )

👉 Measure size/position without destroying the scroll wheel.
""", result: {
    AnyView(ResultBlockView(content: {
        Text("Item")
        .background(
            GeometryReader { geo in
                Color.clear
            }
        )
    }))
}),
        
        Lesson(title: "GeometryReader + ScrollView = dangerous zone", code: """
Example code:

    ScrollView {
        GeometryReader { geo in
            Text("Hello")
        }
    }

❌ Serious error

Why?
    ScrollView does not have a finite size
    GeometryReader has infinite size
    ScrollView cannot determine content size

👉 This leads to:
    jump layout
    scroll lag
    incorrect offset
    CPU spike
""", result: nil),
        
        Lesson(title: "GeometryReader + ScrollView (a deadly trap)", code: """
Example:
    
    ScrollView {
        GeometryReader { geo in
            Text("Hello")
        }
    }

❌ EXTREMELY DANGEROUS
Why?
    GeometryReader occupies unlimited height
    ScrollView doesn't know content size
    Leads to incorrect layout / jumping / lag
""", result: nil),
        
        Lesson(title: "How to use GeometryReader CORRECTLY? (THE MOST IMPORTANT PART)", code: """
✅ Pattern 1 — GeometryReader acts as an observer, not participating in the layout.
👉 BEST PRACTICE

    Text("Hello")
        .background(
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        print(geo.size)
                    }
            }
        )
or
    Text("Hello")
        .overlay(
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        print(geo.size)
                    }
            }
        )

📌 GeometryReader:
    Doesn't take up space
    Doesn't disrupt flow
    Simply "observes"

✅ Pattern 2 — Limit GeometryReader by frame

    GeometryReader { geo in
        Text("Hello")
    }
    .frame(height: 100)

👉 GeometryReader is only allowed to be greedy within 100pt.

✅ Pattern 3 — GeometryReader in ZStack (overlay)

    ZStack { 
        Text("Hello") 
        GeometryReader { geo in 
            Color.clear 
        }
    }

📌 GeometryReader does not push siblings
📌 Used for overlay / effects
""", result: nil),
        
        Lesson(title: "Senior Checklist Before Using GeometryReader", code: """

Before writing GeometryReader, ask yourself:

1️⃣ What am I measuring?
2️⃣ Can I use a background/overlay?
3️⃣ Who is the parent of GeometryReader?
4️⃣ Does GeometryReader participate in the layout flow?
5️⃣ Is it in a ScrollView/Lazy view?

If you can't answer these questions → you shouldn't use it yet.
""", result: nil),
        
        Lesson(title: "Sticky header", code: """
         
    ScrollView {
        VStack {
            GeometryReader { geo in
                Text("Header")
                    .offset(y: max(0, -geo.frame(in: .global).minY))
            }
            .frame(height: 50
    
            ForEach(0..<50) {
                Text("Row ($0)")
            }
        }
    }

📌 Use:
    GeometryReader
    coordinateSpace
    offset
👉 This is a very good interview question.
""", result: {
    AnyView(ResultBlockView(content: {
        ScrollView {
            VStack {
                GeometryReader { geo in
                    Text("Header")
                        .offset(y: max(0, -geo.frame(in: .global).minY))
                }
                .frame(height: 50)

                ForEach(0..<50) {
                    Text("Row \($0)")
                }
            }
        }

    }))
}),
        Lesson(title: "coordinateSpace in ScrollView (very important)", code: """

    ScrollView {
        VStack {
            Text("Item")
        }
    }
    .coordinateSpace(name: "scroll")

    GeometryReader { geo in
        let y = geo.frame(in: .named("scroll")).minY
    }

👉 Used for:
    Tracking scroll offset
    Parallax
    Sticky UI

""", result: {
    AnyView(ResultBlockView(content: {
        ScrollView {
            VStack {
                Text("Item")
            }
        }
        .coordinateSpace(name: "scroll")
        
        GeometryReader { geo in
            let y = geo.frame(in: .named("scroll")).minY
        }
    }))
}),
        
        Lesson(title: "Performance rule (Senior must know)", code: """
         
Performance rules:
    ❌ Do not place GeometryReader directly in the Lazy stack
    ❌ Do not create animations in the onAppear of Lazy items
    ❌ Do not load data in onAppear 
✅ Use task(id:) or ViewModel
      
""", result: nil),
        Lesson(title: "Tracking scroll offset (core use-case)", code: """

    ScrollView {
        VStack {
            GeometryReader { geo in
                Color.clear
                    .onChange(of: geo.frame(in: .global).minY)  oldValue, newValue in
                        print("Scroll Y:", newValue)
                    }
            }
            .frame(height: 0    
            Text("Content")
        }
    }

🧠 Explanation

    geo.frame(in: .global).minY

👉 Gets the position of the GeometryReader relative to the screen
👉 The value changes when scrolling
""", result: {
    AnyView(ResultBlockView(content: {
        
        ScrollView {
            VStack {
                GeometryReader { geo in
                    Color.clear
                        .onChange(of: geo.frame(in: .global).minY) { oldValue, newValue in
                            print("Scroll Y:", newValue)
                        }
                }
                .frame(height: 0)

                Text("Content")
            }
        }

    }))
}),
        Lesson(title: "What is coordinateSpace?", code: """
coordinateSpace defines the coordinate system for measuring position and frame.

Three types:
    .local
    .global
    .named("CustomSpace")

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
            .coordinateSpace(name: "scrollItem")

            GeometryReader { geo in
                let y = geo.frame(in: .named("scrollItem")).minY
                Text("\(y)")
            }

        })
    )
}),
    ]
}
