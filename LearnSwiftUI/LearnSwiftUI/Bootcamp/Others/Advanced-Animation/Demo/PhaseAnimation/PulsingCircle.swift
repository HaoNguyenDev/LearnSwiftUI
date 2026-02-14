//
//  BreathingCirclePhaseAnimation.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

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
