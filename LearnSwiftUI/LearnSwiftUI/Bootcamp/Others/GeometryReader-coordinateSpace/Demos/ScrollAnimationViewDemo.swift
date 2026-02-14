//
//  ScrollAnimationView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/1/26.
//

import SwiftUI

struct ScrollAnimationViewDemo: View {
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geo in
                    let y = geo.frame(in: .global).minY
                    let opacity = max(0, 1 - y / 700)
                    Text("Scale animation \(opacity)")
                        .opacity(opacity)
                        .scaleEffect(opacity)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(.green)
            }
            
            ForEach(0..<40) { num in
                Text("\(num)")
            }
        }
    }
}

#Preview {
    ScrollAnimationViewDemo()
}
