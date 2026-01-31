//
//  ColorRotator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

struct ColorRotator: View {
    var body: some View {
        PhaseAnimator([0, 120, 240, 360]) { degrees in
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(degrees))
                .hueRotation(.degrees(degrees))
        } animation: { _ in
            .easeInOut(duration: 2.0)
        }
    }
}

#Preview {
    ColorRotator()
}
