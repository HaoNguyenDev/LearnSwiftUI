//
//  CardViewModifier.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/2/26.
//

import SwiftUI

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

struct CardViewStrokeModifier: ViewModifier {
    let dashColor: Color
    let cornerRadius: CGFloat
    let dashWidth: [CGFloat]
    
    init(dashColor: Color, cornerRadius: CGFloat, dashWidth: [CGFloat]) {
        self.dashColor = dashColor
        self.cornerRadius = cornerRadius
        self.dashWidth = dashWidth
    }
    
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(dashColor, style: StrokeStyle( lineWidth: 2, lineCap: .round, dash: dashWidth))
            }
    }
}

// Extension for ease of use
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
    
    func cardViewStroke(
        dashColor: Color,
        cornerRadius: CGFloat,
        dashWidth: [CGFloat]) -> some View {
        modifier(
            CardViewStrokeModifier(
                dashColor: dashColor,
                cornerRadius: cornerRadius,
                dashWidth: dashWidth)
        )
    }
    
}

// Usage
struct CustomModifierDemo: View {
    var body: some View {
        VStack(spacing: 24.0) {
            Text("Card Content")
                .cardStyle()
            Text("Card Stroke")
                .cardViewStroke(dashColor: .blue, cornerRadius: 8, dashWidth: [4, 10])
        }
    }
}

#Preview {
    CustomModifierDemo()
}
