//
//  GradientsColorBootCamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

struct GradientsColorBootCamp: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.yellow, .red, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    GradientsColorBootCamp()
}
