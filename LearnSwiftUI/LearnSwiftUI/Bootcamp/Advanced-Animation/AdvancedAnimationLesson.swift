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
""", result: nil),Lesson(title: "PhaseAnimator (iOS 17+) — PHASE ANIMATION", code: """
🎯 Basic Concept
PhaseAnimator is a new view modifier in iOS 17+ 
that allows you to create animations through multiple phases sequentially and automatically.

🧠 When to Use It?
PhaseAnimator is suitable when you need:
    Repeating animations with multiple different states
    Animation sequences with a clear order (A → B → C → A...)
    Loading effects or progress indicators
    Complex animations where you don't want to manually manage state
    Breathing effects, pulsing, or continuous animations

💡 Basic Syntax
    swiftPhaseAnimator(phases) { phase in
        // View changes according to phase
    } animation: { phase in
        // Animation for each phase
    }

🔬 Example:

enum SampleAnimationPhase: CaseIterable {
    case idle
    case loading
    case done
}

struct PhaseAnimationExample: View {

    var body: some View {
        VStack {
            PhaseAnimator(SampleAnimationPhase.allCases) { phase in
                switch phase {
                case .idle:
                    Text("Idle")
                case .loading:
                    ProgressView()
                case .done:
                    Text("Done")
                }
            } animation: { phase in
                switch phase {
                case .idle: .default
                case .loading: .easeInOut
                case .done: .spring
                }
            }
        }
    }
}

📌 Phase = state machine for animation

struct PulsingCircle: View {
    var body: some View {
        PhaseAnimator([false, true]) { phase in
            Circle()
                .fill(.blue)
                .frame(width: 50, height: 50)
                .scaleEffect(phase ? 1.5 : 1.0)
                .opacity(phase ? 0.3 : 1.0)
        } animation: { phase in
            .easeInOut(duration: 0.8)
        }
    }
}

🔄 Comparison with withAnimation
PhaseAnimator                   withAnimation
Automatically                   loops through phases 
Requires manual triggers        Good for continuous animations
Good for one-time animations    Automatic state management 
Requires                        @State management 
iOS 17+                         iOS 13+

""", result: {
        AnyView(ResultBlockView(content: {
            VStack {
                PhaseAnimationExample()
                Spacer()
                PulsingCircle()
                Spacer()
                BouncingText()
                Spacer()
                ColorRotator()
            }.frame(height: 250)
        }))
    }),Lesson(title: "TimelineView — REAL-TIME ANIMATION", code: """
🧠 When to use it?
    Clock
    Audio waveform
    Live data
    Animation independent of user action

Example:

TimelineView(.animation) { context in
    let t = context.date.timeIntervalSince1970
    RoundedRectangle(cornerRadius: 10)
        .fill(.gray)
        .frame(width: 100, height: 100)
        .rotationEffect(.degrees(t * 360))
        .overlay {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 5)
                .rotationEffect(.degrees(t * 60))
                .padding()
        }
}
""", result: {
        AnyView(
            TimelineAnimationExample()
        )
    }),Lesson(title: "", code: """

""", result: nil),Lesson(title: "", code: """

""", result: nil),Lesson(title: "", code: """

""", result: nil)]
}
