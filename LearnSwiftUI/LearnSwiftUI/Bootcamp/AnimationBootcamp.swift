//
//  AnimationBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/6/25.
//

import SwiftUI

struct AnimationBootcamp: View {
    @State private var isShowing = true
    @State private var scale: CGFloat = 1
    
    var body: some View {
        ScrollView {
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        scale = isShowing ? 0.7 : 1
                        isShowing.toggle()
                    }
                    
                } label: {
                    Text("Change animation")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 50)
                        .background(isShowing ? Color.blue : Color.green)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20.0)
                        )

                }
                
                VStack(spacing: 50) {
                    
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill( isShowing ? Color.green : Color.blue)
                        .frame(width: isShowing ? 200 : 200,
                               height: isShowing ? 100 : 200)
                        .rotationEffect(.degrees(isShowing ? 0 : 90))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.brown)
                        .frame(width: 200, height: 100)
                        .rotation3DEffect(.degrees(isShowing ? 0 : 360), axis: (x: 0, y: 1, z: 1))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.red)
                        .frame(width: 200, height: 100)
                        .scaleEffect(scale)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.pink)
                        .frame(width: 200, height: 100)
                        .offset(x: isShowing ? 0 : -200)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.yellow)
                        .frame(width: 200, height: 100)
                        .opacity(isShowing ? 1 : 0)

                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 20)
       
    }
}

#Preview {
    AnimationBootcamp()
}
