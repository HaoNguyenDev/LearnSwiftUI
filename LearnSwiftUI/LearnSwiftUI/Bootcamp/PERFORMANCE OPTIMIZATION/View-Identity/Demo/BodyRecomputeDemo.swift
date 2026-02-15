//
//  BodyRecomputeDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/1/26.
//

import SwiftUI

struct BodyRecomputeDemo: View {
    @State private var count = 0

    var body: some View {
        debugPrint("👉 Body recomputed")
        
        return VStack(spacing: 20) {
            let _ = debugPrint("🔷 VStack body evaluated")
            
            Text("Count: \(count)")
                .padding()
            
            Button("Increment") {
                count += 1
            }
            .buttonStyle(.bordered)
            
            CodePreviewContainer(title: "", code: """

struct BodyRecomputeDemo: View {
    @State private var count = 0

    var body: some View {
        debugPrint("👉 Body recomputed")
        
        return VStack(spacing: 20) {
            Text("Count: \(count)")
            
            Button("Increment") {
                count += 1
            }
            .buttonStyle(.bordered)
            
            CodePreviewContainer(title: "", code: "", resultView: nil)
        }
    }
}

Body Recomputation (View Tree Recalculation)
When you see "👉 Body recomputed" printed, this means:

SwiftUI is recomputing the computed property body.
This happens because the @State private var count changes.
SwiftUI needs to create a new View Tree to compare with the old View Tree.

swiftcount += 1 → @State changes → body is recomputed.
## 2. **View Redraw/Re-render** (Redrawing the actual UI)
After the `body` recompute, the SwiftUI Engine performs:

### **Diffing Algorithm:**
**Old View Tree: New View Tree:**
Old View Tree:         New View Tree:
VStack                 VStack  
├─ Text("Count: 0")    ├─ Text("Count: 1")  ← ONLY TEXT REPLACES CHANGE
└─ Button              └─ Button

SwiftUI compares the two trees and finds:
✅ VStack is identical (same type, same spacing)
✅ Button is identical
❌ Text is different (content changes from "0" → "1")

Result:
VStack does NOT redraw - SwiftUI keeps this view
Button does NOT redraw - SwiftUI keeps this view
ONLY Text redraws - SwiftUI only updates the changed text

Why is that?

SwiftUI uses a declarative + structural identity architecture:
Structural Identity:
swiftVStack(spacing: 20) { ... }

SwiftUI recognizes this as the same VStack through its position in the code.
VStack has no properties dependent on count.
→ SwiftUI optimizes by not redrawing the VStack.

👀 Observation
    Each time the count changes → the body restarts
    No “render loop”
    body = function creating a new View Tree
📌 Conclusion
    body running ≠ view being recreated
    body running = SwiftUI preparing to diff the tree

In summary:
Body recompute = SwiftUI creates a new UI description
View redraw = SwiftUI actually updates the pixels on the screen
SwiftUI is very smart: it only redraws what has actually changed, even if the entire body is redrawn.

""", resultView: nil)
        }
    }
}
