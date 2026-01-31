//
//  PhaseAnimationExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

enum SampleAnimationPhase {
    case idle
    case loading
    case done
}

struct PhaseAnimationExample: View {
    private let animationPhases: [SampleAnimationPhase]
    
    init() {
        animationPhases = [SampleAnimationPhase.idle, SampleAnimationPhase.loading, SampleAnimationPhase.done]
    }
    
    var body: some View {
        VStack {
            PhaseAnimator(animationPhases) { phase in
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

#Preview {
    PhaseAnimationExample()
}
