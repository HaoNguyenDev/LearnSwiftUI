//
//  ParallaxViewDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/1/26.
//

import SwiftUI

struct ParallaxViewDemo: View {
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                let y = geo.frame(in: .global).minY

                VStack {
                    Image(systemName: "arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .offset(y: y * 0.5 )
            }
            .frame(height: 300)

            ForEach(0..<30) { i in
                Text("Item \(i)")
                    .frame(height: 50)
                    .padding()
            }
        }
    }
}

/*
 
 .offset(y: y * 0.5)
 Scroll 100pt → image only shifted 50pt
 This is parallax
 
 */

#Preview {
    ParallaxViewDemo()
}
