//
//  StickyHeaderViewDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/1/26.
//

import SwiftUI

struct StickyHeaderViewDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack {
                    GeometryReader { geo in
                        let y = geo.frame(in: .named("scroll")).minY
                        
                        Text("Sticky Header offset \(y)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 60, alignment: .leading)
                            .background(Color.blue)
                            .offset(y: y < 0 ? -y : 0)
                    }
                }
                .frame(height: 60)
                .padding(.top, 80)

                ForEach(0..<30) { i in
                    Text("Row \(i)")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                }
            }
        }
        .coordinateSpace(name: "scroll")
    }
}

/*
 geo.frame(in: .named("scroll")).minY
 Gets the header position relative to the ScrollView
 
 When scrolling up → minY becomes negative, then set -y to pull it back down
 .offset(y: y < 0 ? -y : 0)
 
 If the header is pushed up → pull it back down
 */

#Preview {
    StickyHeaderViewDemo()
}
