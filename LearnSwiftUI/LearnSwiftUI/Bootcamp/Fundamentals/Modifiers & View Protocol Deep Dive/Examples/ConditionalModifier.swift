//
//  ConditionalModifier.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/2/26.
//

import SwiftUI

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

extension View {
    func conditionModifier(toggleModifier: Bool, trueView: AnyView, falseView: AnyView) -> some View {
        modifier(ConditionalModifier(condition: toggleModifier, trueModifier: { _ in
            trueView
        }, falseModifier: { _ in
            falseView
        }))
    }
}

struct DemoConditionModifiers: View {
    @State private var toggle = false
    
    var body: some View {
        EmptyView()
        .conditionModifier(toggleModifier: toggle,
                               trueView: AnyView(Text("Tap on me").cardStyle()),
                               falseView: AnyView(Text("Tap on me").cardViewStroke(dashColor: .blue, cornerRadius: 8.0, dashWidth: [5, 10])))
        .onTapGesture {
            toggle.toggle()
        }
    }
}

#Preview {
    DemoConditionModifiers()
}


// Modifier with state
struct ShakeModifier: ViewModifier {
    @State private var offset: CGFloat = 10
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

extension View {
    func shakeModifier(shakes: Int) -> some View {
        modifier(ShakeModifier(shakes: shakes))
    }
}

#Preview {
    Text("Hello SwiftUI")
        .shakeModifier(shakes: 5)
}
