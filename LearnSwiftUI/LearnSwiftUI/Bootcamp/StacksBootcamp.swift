//
//  StacksBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/5/25.
//

import SwiftUI

struct StacksBootcamp: View {
    @State private var screenWidth = 0.0
    private var columnCount = 3
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 5) {
                        Rectangle().fill(Color.red)
                            .frame(width: 100, height: 50)
                        
                        Rectangle().fill(Color.green)
                            .frame(width: 80, height: 50)
                        
                        Rectangle().fill(Color.yellow)
                            .frame(width: 70, height: 50)
                        
                    }
                    .frame(width: 100, height: 200, alignment: .center)
                    
                    HStack(alignment: .center, spacing: 10) {
                        ForEach (0..<3) { index in
                            RoundedRectangle(cornerRadius: 10).fill(Color.blue)
                                .frame(width: (screenWidth - 20)/3, height: (screenWidth - 20)/3)
                                .overlay(
                                    Text("\(index)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(width: 200, height: 100)
                            
                            .shadow(radius: 10, x: 0.0, y: 10)
                            .overlay(
                                Text("Hello, World!")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .underline()
                            )
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onAppear {
                    screenWidth = geometry.size.width
                }
            }
        }
    }
}

#Preview {
    StacksBootcamp()
}
