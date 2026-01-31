//
//  BasicMatchedGeometryExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/1/26.
//

import SwiftUI

struct BasicMatchedGeometryExample: View {
    @State private var isExpanded = false
    @Namespace private var animation
    var body: some View {
        VStack {
            if !isExpanded {
                Circle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "shape", in: animation)
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 300, height: 200)
                    .matchedGeometryEffect(id: "shape", in: animation)
            }
            
            Button("Toggle") {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            }
            .padding()
        }
    }
}

#Preview {
    BasicMatchedGeometryExample()
}
