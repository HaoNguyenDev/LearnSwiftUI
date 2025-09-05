//
//  GradientBackground.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


//import SwiftUI
//
//struct GradientBackground: View {
//  var body: some View {
//    MeshGradient(
//      width: 3,
//      height: 3,
//      points: [
//        [0.0, 0.0], [0.3, 0.0], [1.0, 0.0],
//        [0.0, 0.4], [0.5, 0.6], [1.0, 0.4],
//        [0.0, 1.0], [0.7, 1.0], [1.0, 1.0],
//      ],
//      colors: [
//        Color(red: 0.85, green: 0.95, blue: 1.0, opacity: 0.7),
//        Color(red: 0.8, green: 0.9, blue: 1.0, opacity: 0.8),
//        Color(red: 0.75, green: 0.85, blue: 0.95, opacity: 0.7),
//        Color(red: 0.8, green: 0.9, blue: 0.95, opacity: 0.8),
//        Color(red: 0.85, green: 0.9, blue: 1.0, opacity: 0.7),
//        Color(red: 0.8, green: 0.85, blue: 0.95, opacity: 0.8),
//        Color(red: 0.75, green: 0.9, blue: 1.0, opacity: 0.7),
//        Color(red: 0.8, green: 0.85, blue: 1.0, opacity: 0.8),
//        Color(red: 0.85, green: 0.9, blue: 0.95, opacity: 0.7),
//      ]
//    )
//    .ignoresSafeArea()
//  }
//}

//#Preview {
//  GradientBackground()
//}

import SwiftUI

struct GradientBackgroundAnimation: View {
    @State private var startPointX: CGFloat = 0.0
    @State private var startPointY: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.4),
                    Color.purple.opacity(0.4),
                    Color.pink.opacity(0.4)
                ]),
                startPoint: UnitPoint(x: startPointX, y: startPointY),
                endPoint: UnitPoint(x: 1.0 - startPointX, y: 1.0 - startPointY)
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 8) // Tăng thời gian để hiệu ứng mượt hơn
                    .repeatForever(autoreverses: true)
                ) {
                    self.startPointX = 1.0
                    self.startPointY = 1.0
                }
            }
        }
    }
}

#Preview {
    GradientBackgroundAnimation()
}
