//
//  CardExpansionExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/1/26.
//

import SwiftUI

struct CardExpansionExample: View {
    @State private var selectedCard: Int? = nil
    @Namespace private var animation
    
    let colors: [Color] = [.red, .green, .blue, .orange]
    
    var body: some View {
        ZStack {
            if selectedCard == nil {
                // Grid view
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<4) { index in
                        CardView(color: colors[index])
                            .matchedGeometryEffect(id: index, in: animation)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                    selectedCard = index
                                }
                            }
                    }
                }
                .padding()
            } else {
                // Full screen view
                ZStack(alignment: .topTrailing) {
                    CardView(color: colors[selectedCard!])
                        .matchedGeometryEffect(id: selectedCard!, in: animation)
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            selectedCard = nil
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding()
            }
        }
    }
}

struct CardView: View {
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(color)
            .frame(height: 200)
    }
}

#Preview {
    CardExpansionExample()
}
