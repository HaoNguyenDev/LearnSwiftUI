//
//  ModifiersViewProtocolLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/2/26.
//

import SwiftUI

struct ModifiersViewProtocolLesson {
    static let all = [
        Lesson(title: "", code: """
After this lesson, you will have a deep understanding of:
View protocol and how SwiftUI rendering works
Modifier system and order of modifiers
Custom modifiers and ViewModifier protocol
Environment and EnvironmentValues
Performance considerations
""", result: nil),
        Lesson(title: "1. View Protocol Deep Dive"),
        Lesson(title: "1.1 What is View Protocol?", code: """
1.1 What is View Protocol?

public protocol View {
    associatedtype Body: View
    @ViewBuilder var body: Self.Body { get }
}

Key concepts:
A View is a description of the UI, not the UI object itself.
A View is a struct (value type), not a class.
A View is recreated whenever the state changes.
SwiftUI compares View descriptions to update the UI efficiently.
""", result: nil),
        Lesson(title: "1.2 View Lifecycle", code: """
struct LifecycleDemo: View {
    @State private var counter = 0
    
    init() {
        print("1. Init called")
    }
    
    var body: some View {
        debugPrint("2. Body computed")
        return VStack {
            Text("Counter: (counter)")
            Button("Increment") {
                counter += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            print("3. OnAppear called")
        }
    }
}

Flow:

1 View is initialized
2 Body is computed
3 SwiftUI renders UI
4 onAppear is called
5 When state changes → body is recomputed
""", result: {
    AnyView(ResultBlockView(content: {
        LifecycleDemo()
    }))
}),
        Lesson(title: "1.3 Never Type & EmptyView", code: """
// Never body - for primitive views
struct Image: View {
    var body: Never {
        fatalError()
    }
}

// EmptyView - no render UI
struct ConditionalView: View {
    let showContent: Bool
    
    var body: some View {
        if showContent {
            Text("Content")
        } else {
            EmptyView()
        }
    }
}
""", result: nil),
        Lesson(title: "2. Modifier System"),
        Lesson(title: "2.1What are Modifiers?", code: """
Modifiers are methods that return a new view with the modifications applied.

struct ModifierDemo: View {
    var body: some View {
        // Every modifier create a new view wrapper
        Text("Hello")
            .foregroundColor(.blue)    // ModifiedContent<Text, _ColorModifier>
            .font(.title)              // ModifiedContent<ModifiedContent<...>, _FontModifier>
            .padding()                 // ModifiedContent<ModifiedContent<...>, _PaddingModifier>
    }
}
""", result: nil),
        Lesson(title: "2.2 Order of Modifiers (IMPORTANT!)", code: """
The order of modifiers directly affects the results:

VStack(spacing: 30) {
    // Case 1: Background first, padding later
    Text("Hello")
        .background(Color.blue)
        .padding()
    // → Blue background, white padding
    
    // Case 2: Padding first, background later
    Text("Hello")
        .padding()
        .background(Color.blue)
    // → Blue background extends to padding
    
    // Case 3: Multiple backgrounds
    Text("Hello")
        .padding()
        .background(Color.blue)
        .padding()
        .background(Color.red)
    // → Nested backgrounds
}

Golden rule:
Layout modifiers (padding, frame) → affect size
Visual modifiers (background, border) → use current size
Apply layout first, then visual
""", result: {
    AnyView(ResultBlockView(content: {
        OrderMattersDemo()
    }))
}),
        Lesson(title: "2.3 Common Modifier Patterns", code: """
VStack(spacing: 20) {
    // Pattern 1: Card style
    Text("Card Content")
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 5)
    
    // Pattern 2: Button style
    Text("Button")
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 5)
    
    // Pattern 3: Input field
    Text("Input")
        .padding()
        .background(Color.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue,style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [10]))
        )
}
""", result: {
    AnyView(ResultBlockView(content: {
        ModifierPatterns()
    }))
}),
        Lesson(title: "3. Custom Modifiers"),
        Lesson(title: "3.1 ViewModifier Protocol", code: """
Create struct conform ViewModifier protocol
and implement body function

    func body(content: Content) -> some View

Example:

struct CardViewModifier: ViewModifier {
    let backgroundColor: Color
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

extension View {
    func cardStyle(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = 10
    ) -> some View {
        modifier(CardViewModifier(
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius
        ))
    }
}

// Usage
Text("Card Content")
    .cardStyle()

""", result: {
    AnyView(ResultBlockView(content: {
        VStack(spacing: 24.0) {
            Text("Card Content")
                .cardStyle()
            
            Text("Card Stroke")
                .cardViewStroke(dashColor: .blue, cornerRadius: 8, dashWidth: [4, 10])
        }
    }))
}),
        Lesson(title: "3.2 Advanced Custom Modifiers", code: """
// Modifier with complex logic
struct ConditionalModifier<TrueContent: View, FalseContent: View>: ViewModifier {
    let condition: Bool
    let trueModifier: (AnyView) -> TrueContent
    let falseModifier: (AnyView) -> FalseContent
    
    func body(content: Content) -> some View {
        if condition {
            trueModifier(AnyView(content))
        } else {
            falseModifier(AnyView(content))
        }
    }
}

// Modifier with state
struct ShakeModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    let shakes: Int
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset)
            .animation(
                Animation.easeInOut(duration: 0.1)
                    .repeatCount(shakes),
                value: offset
            )
    }
    
    func shake() {
        offset = 10
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(shakes)) {
            offset = 0
        }
    }
}
""", result: nil),
        Lesson(title: "3.3 Composable Modifiers", code: """
// Create modifier from small modifiers
struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .modifier(ButtonShapeModifier())
            .modifier(ButtonShadowModifier())
    }
}

struct ButtonShapeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct ButtonShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}
""", result: nil)
    ]
}
