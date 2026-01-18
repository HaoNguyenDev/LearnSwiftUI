//
//  ExpandCardAnimationDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/1/26.
//

import SwiftUI

struct ExpandCardAnimationDemo: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Title")
                Text("Description")
                if isExpanded {
                    Text("More detailed content goes here...")
                        .padding(.top)
                        .transition(.scale)
                }
                Button("More...") {
                    withAnimation(.smooth) {
                        isExpanded.toggle()
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }.background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.green)
        )
    }
}

#Preview {
    ExpandCardAnimationDemo()
}
