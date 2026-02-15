//
//  PhaseAnimationExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

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

#Preview {
    PhaseAnimationExample()
}
