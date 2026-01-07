//
//  AlignmentLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/1/26.
//

import SwiftUI

struct AlignmentLessons {
    static let all: [Lesson] = [
        Lesson(title: "Alignment & AlignmentGiude",
               code: """
Fundamental mindset (must be finalized first)

❗ Alignment NEVER affects size
❗ Alignment only affects placement

Many developers misunderstand this point.

1️⃣ What is alignment in a stack?

Example:

   VStack(alignment: .leading) {
       Text("Short")
           .background(.green)
       Text("This is a very long text")
           .background(.blue)
   }
   .background(.orange)

What happens?
    VStack still has the same size.
    The Text only changes position along the secondary axis.
📌 With VStack:
    Main axis: vertical (aligned from top to bottom)
    Cross axis: horizontal → alignment applies here.
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       VStack(alignment: .leading) {
                           Text("Short")
                               .background(.green)
                           Text("This is a very long text")
                               .background(.blue)
                       }
                       .background(.orange)
                   }))
               }),
        
        Lesson(title: "Does alignment cause the view to expand?",
               code: """
Example:

    Text("Hello")
        .frame(maxWidth: .infinity, alignment: .leading)

✅ True to nature:
    Frame expands
    Text does not expand
    Alignment only determines where the text is positioned within the frame
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Hello")
                           .background(.green)
                           .frame(maxWidth: .infinity, alignment: .leading)
                           .background(.gray)
                   }))
               }),
        
        Lesson(title: "alignment in frame(...)",
               code: """
 VStack {
     Text("A")
     Text("B")
 }
 .frame(height: 200, alignment: .bottom)

👉 What changed?
    VStack height 200
    Two Texts are at the bottom
    Excess space still belongs to the VStack
📌 alignment ≠ Spacer
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       VStack {
                           Text("A")
                               .background(.green)
                           Text("B")
                               .background(.blue)
                       }
                       .frame(height: 100, alignment: .bottom)
                       .background(.gray)
                   }))
               }),
        
        Lesson(title: "AlignmentGiude",
               code: """
What is alignment guide?

AlignmentGuide allows the child to tell the parent:
"Where is my alignment point?" 

✅ Alignment Guide = Changes the child's alignment coordinate system.
✅ Parents must respect the alignment of all children, even when expanding the size.

AlignmentGuide doesn't shift the view;
it changes how the parent calculates alignment lines and sizes.

⚠️ This is override the default alignment.

Example: 
    VStack(alignment: .leading) {
        Text("A")
        Text("B")
            .alignmentGuide(.leading) { b in
                b[.trailing]
            }
    }

Explanation:
    VStack is aligned with .leading
    But Text("B") says:
    “my leading = my trailing”
    👉 Text("B") is pushed to the left

AlignmentGuide doesn't shift the view;
it changes how the parent calculates alignment lines and sizes.
🔥 This is a true “layout hack”.

When does alignmentGuide work?
❗ It only works when:
    The parent has alignment
    alignmentGuide matches that alignment

Example:
    VStack(alignment: .leading)
    alignmentGuide(.leading) ✅
    alignmentGuide(.top) ❌ (does not work)
""",
               result: {
                   AnyView( ResultBlockView(content: {
                       VStack(alignment: .leading) {
                           Text("A")
                               .background(.green)
                           Text("B")
                               .background(.blue)
                               .alignmentGuide(.leading) { b in
                                   b[.trailing]
                               }
                       }
                       .background(.gray)
                   })
                   )
               }),
        
        Lesson(title: "alignmentGuide Example",
               code: """
Example:

	VStack(alignment: .leading) {
	    Text("A")
	        .background(.green)
	    Text("B")
	        .background(.blue)
	        .alignmentGuide(.leading) { b in
	            b[.trailing]
	        }
	    Text("A")
	        .background(.orange)
	}
	.background(.gray)

In the example above, if you look at the Result UI, you will see that B is shifted to the left because:
- The leading of B is now calculated from the trailing of the previous B, B overrides its own leading alignment to be its trailing edge. 
- B is positioned to the left so that its trailing edge aligns with the VStack’s alignment line.
- A and C remain correctly aligned to the VStack’s leading alignment line,
but the alignment line itself has moved due to B’s alignment override.
The current alignment line of the VStack is actually aligned with the leading of A and C.
The extra space is the space due to Vstack expanding its width to fully accommodate its children
📌 The alignment line is not fixed at the left edge of the VStack.
📌 It is calculated dynamically.

""",
               result: {
                   AnyView(
                    ResultBlockView {
                        VStack(alignment: .leading) {
                            Text("A")
                                .background(.green)
                            Text("B")
                                .background(.blue)
                                .alignmentGuide(.leading) { b in
                                    b[.trailing]
                                }
                            Text("C")
                                .background(.orange)
                        }
                        .background(.gray)
                    }
                   )
               }),
        
        Lesson(title: "",
               code: """

""",
               result: nil),
    ]
}
