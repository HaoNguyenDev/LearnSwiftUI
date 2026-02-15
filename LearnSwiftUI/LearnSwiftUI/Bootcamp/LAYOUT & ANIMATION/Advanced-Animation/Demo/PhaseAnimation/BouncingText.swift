//
//  BouncingText.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

struct BouncingText: View {
    var body: some View {
        PhaseAnimator([0, -20, 0, 10, 0]) { offset in
            Text("Hello!")
                .font(.largeTitle)
                .offset(y: offset)
        } animation: { _ in
            .bouncy
        }
    }
}

#Preview {
    BouncingText()
}
