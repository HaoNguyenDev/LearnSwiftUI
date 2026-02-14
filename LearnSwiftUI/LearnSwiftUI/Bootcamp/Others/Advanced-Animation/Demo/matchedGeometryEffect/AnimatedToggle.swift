//
//  AnimatedToggle.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/1/26.
//

import SwiftUI

struct AnimatedToggle: View {
    @State private var isOn = false
    @Namespace private var animation
    
    var body: some View {
        HStack {
            Text(isOn ? "ON" : "OFF")
                .font(.caption)
                .fontWeight(.bold)
            
            ZStack(alignment: isOn ? .trailing : .leading) {
                // Background
                Capsule()
                    .fill(isOn ? Color.green : Color.gray.opacity(0.3))
                    .frame(width: 60, height: 32)
                
                // Moving circle
                Circle()
                    .fill(.white)
                    .frame(width: 28, height: 28)
                    .padding(2)
                    .matchedGeometryEffect(id: "toggle", in: animation)
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.3)) {
                    isOn.toggle()
                }
            }
        }
    }
}

#Preview {
    AnimatedToggle()
}
