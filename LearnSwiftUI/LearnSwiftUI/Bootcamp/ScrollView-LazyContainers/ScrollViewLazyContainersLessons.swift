//
//  ScrollViewLazyContainersLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/1/26.
//

import SwiftUI

struct ScrollViewLazyContainersLessons {
    static let all: [Lesson] = [
        Lesson(title: "Layout, lifecycle & performance traps", code: """
Opening statement (very important)
❗ ScrollView does NOT know the size of its content
❗ Lazy container does NOT create a view immediately      
""", result: nil),
        
        Lesson(title: "How does ScrollView work? (in essence)", code: """
Example:

	ScrollView {
	    VStack {
	        Text("A")
	            .background(.green)
	        Text("B")
	            .background(.blue)
	    }
	    .frame(width: 100)
	    .background(.white)
	}
	.frame(width: 200)
	.background(.secondary)

         
Important things to remember:
ScrollView:
    ❌ Does not force height for content
    ❌ Does not know the total height of the content
    ✅ Only allows content to scroll infinitely along the axis
📌 ScrollView always suggests an “undefined” size for content along the scroll axis.  
""", result: {
    AnyView(ResultBlockView(content: {
        ScrollView {
            VStack {
                Text("A")
                    .background(.green)
                Text("B")
                    .background(.blue)
            }
            .frame(width: 100)
            .background(.white)
        }
        .frame(width: 200)
        .background(.secondary)
    }))
}),
        Lesson(title: "Why does ScrollView + VStack often cause Spacer bugs?", code: """
Example:

	ScrollView {
	    VStack {
	        Text("TOP")
	            .background(.green)
	        Spacer()
	    }
	    .frame(width: 100)
	    .background(.white)
	}
	.frame(width: 200)
	.background(.secondary)

❌ Spacer is NOT working
Why?
    ScrollView does not have a finite height
    VStack does not have extra space
    Spacer = 0

Because the default size of the Spacer() is 8pt if the parent doesn't have extra space,
 you'll see an 8pt gap along the main axis of the stack.
That's mean Spacer(minLength: 8), set to 0 if you want
👉 This is a very common interview trap.
""", result: {
    AnyView(ResultBlockView(content: {
        ScrollView {
            VStack {
                Text("TOP")
                    .background(.green)
                Spacer()
            }
            .frame(width: 100)
            .background(.orange)
        }
        .frame(width: 200)
        .background(.secondary)
    }))
}),
        
        Lesson(title: "What is LazyVStack / LazyHStack?", code: """
Lazy containers only create views when needed.
Example:

	ScrollView(.horizontal, showsIndicators: true) {
	    LazyHStack {
	        ForEach(0..<100) {
	            Text("Row ($0)")
	        }
	    }
	}

📌 View:
    Created only when scrolled to
    Cancelled when left the display area

Comparing VStack vs LazyVStack (must know this)

| Criteria      | VStack                | LazyVStack          |

| --------------| ----------------      | -------------       |

| Create view   | Immediately           | When needed         |

| Performance   | Poor with large lists | Good                |

| GeometryReader| Prone to bugs         | Requires caution    |

| onAppear      | Call once             | Call multiple times |
""", result: {
    AnyView(ResultBlockView(content: {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack {
                ForEach(0..<100) {
                    Text("Row \($0)")
                }
            }
        }
    }))
}),
        
        Lesson(title: "The Big Trap: onAppear in LazyVStack", code: """
           
Example:

        LazyVStack {
            Text("Item")
                .onAppear {
                    print("Appear")
                }
        }

⚠️ onAppear:
    Can call multiple times
    Call again when scrolling up/down
👉 DO NOT use onAppear to load data all at once
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
        
        Lesson(title: "Geometry Reader?", code: """
What exactly is a Geometry Reader?
Standard Definition (Senior):

    A GeometryReader is a View that always occupies the entire proposal given to it by its parent,
and provides the child with geometric information (size, position) of that space.

📌 It doesn't measure the child
📌 It measures the space it occupies
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
      
""", result: {
    AnyView(ResultBlockView(content: {
        
    }))
}),
        Lesson(title: "", code: """
               
""", result: {
    AnyView(ResultBlockView(content: {
        
    }))
}),
        
    ]
}

