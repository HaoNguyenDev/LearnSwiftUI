//
//  ScrollViewLazyContainersLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/1/26.
//

import SwiftUI

struct ScrollViewLazyContainersLessons {
    static let all: [Lesson] = [
        
        Lesson(title: "What exactly is ScrollView?", code: """
Standard Definition (Senior):

    ScrollView is a container that allows content to scroll infinitely along an axis,
and does not provide a finite proposal for content along that axis.
It does NOT manage layout space for content.

❗ ScrollView does NOT know the size of its content.
❗ ScrollView does not force the size of content.
📌 ScrollView:
    ❌ Does not know the total height (vertical)
    ❌ Does not know the total width (horizontal)
    ❌ ScrollView does not resize content
    ❌ ScrollView does not divide space (Spacer does not automatically work) 
✅ 👉 ScrollView only provides a scrolling mechanism, it's not a layout manager.
""", result: nil),
        
        Lesson(title: "ScrollView in layout cycle", code: """
🔁 Parent → ScrollView
Parent suggests size (usually full screen)

🔁 ScrollView → Content
Along the scroll axis:
proposal = undefined / infinite
Along the secondary axis:
proposal = finite

📌 With ScrollView(.vertical):
Height: undefined
Width: equal to parent

Example:

        VStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack {
                    Text("Text")
                }
                .background(.green)
            })
            .background(.gray)
        }
        .frame(height: 100)
        .background(.blue)

Above example explanation: 
🔁 Parent → ScrollView
Parent suggests size for ScrollView with height = 100pt
Then result UI showing a gray ScrollView with height = 100pt
Becase blue VStack are them same size with ScrollView that why you will not see the blue VStack

🔁 ScrollView → Content (VStack blue)
Along the scroll axis:
proposal = height 100pt
Along the secondary axis:
proposal = finite

""", result: {
    AnyView(ResultBlockView(content: {
        
        VStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack {
                    Text("Text")
                }
                .background(.green)
            })
            .background(.gray)
        }
        .frame(height: 100)
        .background(.blue)
        
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
            .background(.orange)
        }
        .frame(width: 200)
        .background(.secondary)
        
    }))
}),
        Lesson(title: "When can Spacers work in a ScrollView?", code: """
Only when you create a finite height for the content:
        
            ScrollView {
                VStack {
                    Text("Top")
                    Spacer()
                    Text("Bottom")
                }
                .frame(minHeight: 100)
            }
        
📌 At this point:
VStack has a specific height
Spacer has space to expand
""", result: {
    AnyView(ResultBlockView(content: {
        
            ScrollView {
                VStack {
                    Text("Top")
                    Spacer()
                    Text("Bottom")
                }
                .frame(minHeight: 100)
            }
        
    }))
}),
        
        Lesson(title: "Debug ScrollView", code: """
Always ask yourself:
    1️⃣ What is the scroll axis?
    2️⃣ Does content have a finite height?
    3️⃣ Does the spacer have enough space?
    4️⃣ Is GeometryReader greedy?
    5️⃣ Does lazy generate too many views?
""", result: nil),
        
//MARK: - Lazy Container
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

Lazy containers are like windows looking at a list.
Only items within those windows "exist".

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
        
        Lesson(title: "Layout, lifecycle & performance traps", code: """
❗ ScrollView does NOT know the size of its content
❗ Lazy container does NOT create a view immediately      
""", result: nil),
        
        Lesson(title: "ScrollView + VStack vs LazyVStack (very important)", code: """
❌ Common Mistake

	ScrollView {
	    VStack {
	        ForEach(0..<1000) {
	            Text("Row ($0)")
	        }
	    }
	}

 👉 Creates 1000 views at once
👉 Very high memory and layout cost

✅ The correct way (production)

	ScrollView {
	    LazyVStack {
	        ForEach(0..<1000) {
	            Text("Row ($0)")
	        }
	    }
	}

📌 LazyVStack:
🧠 Explanation of the nature (very important)
🔑 LazyVStack doesn't make things lazy on its own.
It only delays child creation WHEN the child is animated.

Creates views only when needed
Cancels views when exiting the viewport
Optimizes memory and layout
""", result: {
    AnyView(ResultBlockView(content: {
        
        ScrollView {
            VStack {
                ForEach(0..<10) {
                    Text("Row \($0)")
                }
            }
        }

    }))
}),
        
    Lesson(title: "The CORRECT case (truly lazy)", code: """

    ScrollView {
        LazyVStack {
            ForEach(0..<100) { i in
                Text("(i)")
            }
        }
    }

👉 At this point:
ForEach:
    Generates the view as required
LazyVStack:
    Decides when item i is needed
    Only creates the item in the viewport (+ buffer)
📌 Lazy = 100%
""", result: nil),
        
        Lesson(title: "Why is ForEach a MANDATORY condition for lazy?", code: """
Because lazy only makes sense when there is a set of elements that can be delayed in creation.

Without ForEach:
LazyVStack only sees:
	child 1
	child 2
	child 3
	...
	child 100

👉 There is no way to say:
    “Only create child 0–10 first”

With ForEach:
    LazyVStack sees:
        ForEach(range: 0..<100)
👉 It can say:
    “Only need item 0–10 now”
""", result: nil),
        
        Lesson(title: "The correct relationship between ScrollView – Lazy – ForEach", code: """
Standard formula (memorize it)

	ScrollView
	 └── Lazy container
	      └── ForEach
	           └── Row

""", result: nil),
        
        Lesson(title: "Where does Lazy work?", code: """
Where does Lazy work?
🔑 Lazy works at the level where the container sees the ENTIRE list.
Comparison:
✅ CORRECT

    LazyVStack {
        ForEach(items) {
            Row()
        }
    }

👉 LazyVStack:
Sees all items

Decides:
items 0–10 need to render
items 11–100 don't need to yet

❌ INCORRECT

    ForEach(items) {
        LazyVStack {
            Row()
        }
    }

👉 Each LazyVStack:
Only sees 1 Row
Nothing to lazy

Example of visual comparison
You want:
📦 LazyVStack

	├─ Row 1
	├─ Row 2
	├─ Row 3
	├─ ...

You do NOT want:
	📦 Row 1 → 📦 LazyVStack
	📦 Row 2 → 📦 LazyVStack
	📦 Row 3 → 📦 LazyVStack

A very common misconception
❌ Wrong idea:
    “ForEach is a loop, so it determines laziness”
❌ Wrong.

In reality:
    ForEach is not lazy
    Lazy only comes from:
    LazyVStack
    LazyHStack
    LazyVGrid
    List
""", result: nil),
        
        Lesson(title: "The Big Trap: onAppear in LazyVStack", code: """

LazyVStack — Understanding the Lifecycle Correctly    

A common misconception among developers:       
Common mistake:

        LazyVStack {
            Text("Item")
                .onAppear {
                    print("Appear")
                }
        }

❗ onAppear:
    Can call multiple times
    Call again when scrolling up/down
❌ DO NOT use onAppear to load data all at once

✅ Correct way
    Load data in:
    ViewModel
    .task(id:)
    .onAppear of the container, not the item
""", result: nil),
        
        Lesson(title: "Performance checklist (MUST MEMORIZE)", code: """
❌ Avoid:
    Large VStack + ForEach
    GeometryReader in Lazy item
    onAppear to load data
    Animation in Lazy item
    Heavy view in cell

✅ Recommended:
    LazyVStack / LazyHStack
    List for large data
    background/overlay GeometryReader
    ViewModel to retain state
    .drawingGroup() when needed
""", result: nil),
        
        Lesson(title: "🧠 LAZY LIFECYCLE — APPEAR / DISAPPEAR / REUSE", code: """
We're talking about:
    LazyVStack
    LazyHStack
    LazyVGrid
in ScrollView

0️⃣ A final point before going into detail:
    ❗ Lazy containers DO NOT keep views alive for long periods.
    ❗ Lazy containers DO NOT reuse views like UITableView.
    ❗ Lazy containers can destroy and recreate views at any time.

If you haven't grasped these 3 points → you will use onAppear incorrectly.

1️⃣ What are the actual phases of the lazy lifecycle?

At the engine level, a lazy item can go through:
    Create
    Appear
    Disappear
    Destroy
    (Possibly) Recreate
👉 There is no concept of "fixed reuse".

2️⃣ Create — When is the view created?

Example:
        ScrollView {
            LazyVStack {
                ForEach(0..<100) { i in
                    Text("Row (i)")
                }
            }
        }

What happens at the beginning?
    SwiftUI does NOT create 100 Texts.
It only creates:
    Items in the viewport
    a small buffer above/below

📌 Example:
    The screen displays 10 rows
    SwiftUI creates ~12–15 rows
👉 This is lazy creation

3️⃣ onAppear — When is it called?

    Text("Row (i)")
        .onAppear {
            print("Appear (i)")
        }

onAppear is called when:
The view starts participating in the layout & render tree

📌 Important:
    Not when the body is evaluated
    But when the view actually appears on the screen
    ❗ onAppear does NOT guarantee a one-time call

Scroll up → call
Scroll down → call
Scroll quickly → call multiple times
Orientation change → call again
👉 onAppear ≠ viewDidLoad

4️⃣ onDisappear — When is it called?

    .onDisappear {
        print("Disappear (i)")
    }

onDisappear is called when:
The View is removed from the render tree
📌 This does not mean:
    The View is deinit immediately
    Or the state is lost immediately
👉 But it is very likely that it will be destroyed.

5️⃣ Destroy — When is a view destroyed?
⚠️ SwiftUI doesn't guarantee a destruction time.
But usually:
When the view:
    Leaves the viewport
    And the system needs to free up memory
👉 It can:
    Destroy immediately
    Or keep it temporarily
    Or recreate it later
📌 No reuse contract

6️⃣ Reuse — A VERY IMPORTANT FACT
❌ Common Misconceptions
    LazyVStack reuses views like UITableView
❌ FALSE

✅ In reality
SwiftUI:
    ❌ Does not reuse view instances
    ❌ Does not guarantee the identity of view objects
SwiftUI: 
    ✅ Reuses data
    ✅ Recomputes View structs
📌 Views in SwiftUI:
    Are value types
    Very cheap to recreate

7️⃣ Identity — the lifecycle determinant
Why is ID in ForEach EXTREMELY important?

    ForEach(items, id: .id) { item in
        Row(item: item)
    }

SwiftUI uses ID to:
    Know which item is which
    Assign the correct state to the item
    Decide:
    destroy
    recreate
    update

❌ Extremely dangerous error

    ForEach(items.indices) { i in
        Row(item: items[i])
    }

👉 When inserting/deleting:
    Index changes
    SwiftUI uses the wrong identity
    State jumps erratically

8️⃣ State in Lazy Items — EXTREMELY BUG-PRONE

    struct Row: View {
        @State private var isOn = false
    }

What can happen?

Scroll away → Row is destroyed
Scroll again → Row is created again
isOn → reset
👉 This is the correct behavior

✅ Correct way (Senior pattern)
Putting state outside:
    ViewModel
    Parent view
    Or attach state by ID

9️⃣ Why shouldn't you load data in the onAppear of a Lazy item?

    .onAppear {
        loadData()
    }

❌ Incorrect because:
    onAppear is called multiple times
    Scroll → reloads
Causes:
    duplicate request
    race condition
    lag
✅ Correct pattern: Controlled pagination:
    .onAppear {
        if item.id == items.last?.id {
            loadNextPage()
        }
    }


""", result: nil)
        
    ]
}
