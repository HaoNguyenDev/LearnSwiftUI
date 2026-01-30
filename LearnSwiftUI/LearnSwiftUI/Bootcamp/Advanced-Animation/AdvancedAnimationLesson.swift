//
//  AdvancedAnimationLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/1/26.
//

import SwiftUI

struct AdvancedAnimationLesson {
    static let all = [Lesson(title: "CORE THINKING (VERY IMPORTANT)", code: """
SwiftUI does not animate views
SwiftUI animates state changes over time

📌 If you cannot control:
    state
    identity
    timeline

➡️ Animation will fail, stutter, or disappear
""", result: nil),Lesson(title: "matchedGeometryEffect", code: """
🧠 What does matchedGeometryEffect do?

It tells SwiftUI:
“These two views are the same entity, only differing in position/shape over time.”

📌 It works 100% based on identity.

🔑 REQUIRED conditions for correct execution:
    Same ID
    Same Namespace
    View appears in two different layouts
    Transition occurs within the same transaction

✅ STANDARD example

    @Namespace private var ns
    @State private var isExpanded = false

    var body: some View { 
        VStack { 
            if isExpanded { 
                avatar 
                    .matchedGeometryEffect(id: "avatar", in: ns) 
            } else { 
                avatar 
                    .matchedGeometryEffect(id: "avatar", in: ns) 
            } 
        }
    }

    var avatar: some View { 
        Image("avatar")
    }

🧠 matchedGeometryEffect & Diffing
    SwiftUI does not animate
    SwiftUI interpolate geometry between 2 frames
➡️ Identity is wrong = SwiftUI doesn't know where to interpolate from → FAIL
""", result: nil),Lesson(title: "", code: """

""", result: nil),Lesson(title: "", code: """

""", result: nil),Lesson(title: "", code: """

""", result: nil),Lesson(title: "", code: """

""", result: nil),Lesson(title: "", code: """

""", result: nil)]
}
