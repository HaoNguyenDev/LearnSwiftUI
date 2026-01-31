//
//  CardExpansionExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/1/26.
//

import SwiftUI

struct CardExpansionExample: View {
    @State private var selectedCardIndex: Int?
    @Namespace private var animation
    
    let colors: [Color] = [.red, .green, .blue, .orange]
    let columsSetup = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            if selectedCardIndex == nil {
                // Grid view
                LazyVGrid(columns: columsSetup) {
                    ForEach(0..<colors.count, id: \.self) { index in
                        CardView(color: colors[index])
                            .matchedGeometryEffect(id: index, in: animation)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                    selectedCardIndex = index
                                }
                            }
                    }
                }
                .padding()
            } else {
                // Full screen view
                ZStack(alignment: .topTrailing) {
                    CardView(color: colors[selectedCardIndex ?? 0])
                        .matchedGeometryEffect(id: selectedCardIndex!, in: animation)
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedCardIndex = nil
                            }
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
