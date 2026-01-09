//
//  CollapseToolbarViewDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/1/26.
//

import SwiftUI

struct CollapseToolbarViewDemo: View {
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geo in
                    let y = geo.frame(in: .named("scroll")).minY
                    let height = max(60, 200 - y)

                    VStack(spacing: 01) {
                        Text("Toolbar")
                        Image(systemName: "arrow.down")
                    }
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                }
                .frame(height: 200)

                ForEach(0..<30) { i in
                    Text("Row \(i)")
                        .frame(height: 50)
                }
            }
        }
        .coordinateSpace(name: "scroll")
    }
}

/*
 let height = max(60, 200 - y)
 Toolbar minimizes but not to less than 60
 */

#Preview {
    CollapseToolbarViewDemo()
}
