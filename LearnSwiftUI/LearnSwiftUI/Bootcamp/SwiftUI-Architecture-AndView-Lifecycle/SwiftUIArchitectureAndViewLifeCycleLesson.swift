//
//  SwiftUIArchitectureAndViewLifeCycleLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

struct SwiftUIArchitectureAndViewLifeCycleLesson {
    static let all = [Lesson(title: "Core Knowledge", code: """
Declarative vs. Imperative Programming

SwiftUI is declarative: you describe "what" not "how"
View is a function of state: View = f(State)
Automatic UI updates when state changes

View Protocol & Body Property

Every View must conform to the View protocol
Body property returns some View (Opaque type)
View is a struct (value type), not a class
Views are created and destroyed continuously (cheap to create)

View Identity & Lifetime

Structural identity: position in the view tree
Explicit identity: uses the .id() modifier
View lifetime is different from state lifetime
SwiftUI uses diffing algorithms to optimize updates

Rendering Pipeline

View creation → Body evaluation → Layout → Rendering
View tree → Render tree → Display list
Understanding view tree vs. render tree
""", result: nil)]
}
