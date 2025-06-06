//
//  SateBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/6/25.
//

import SwiftUI

struct SateBootcamp: View {
    
    @State private var number: Int = 0
    @State private var viewBackgroundColor: Color = .blue
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Count Test")
                    .padding()
                    .font(.dosis(fontweight: .bold, size: 34.0))
                    .foregroundStyle(.white)
                
                Text("Numbner: \(number)")
                    .padding()
                    .font(.dosis(fontweight: .semibold, size: 34.0))
                    .foregroundStyle(.yellow)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        increment()
                    }) {
                        Text("+")
                            .padding(.top, -10)
                            .font(.dosis(fontweight: .bold, size: 34.0))
                            .frame(width: 100, height: 50)
                            .foregroundStyle(.blue)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                        .frame(width: 40)
                    
                    Button {
                        decrement()
                    } label: {
                        Text("-")
                            .padding(.top, -10)
                            .font(.dosis(fontweight: .bold, size: 34.0))
                            .frame(width: 100, height: 50)
                            .foregroundStyle(.blue)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            .background(viewBackgroundColor)
            .cornerRadius(20)
            .padding(.horizontal, 30)
        }
        .ignoresSafeArea(.all)
        
    }
    
    private func increment() {
        number += 1
        checkPositiveNumber()
    }
    
    private func decrement() {
        number -= 1
        checkPositiveNumber()
    }
    
    private func checkPositiveNumber() {
        viewBackgroundColor = number > 0 ? Color.blue : Color.red
    }
}


#Preview {
    SateBootcamp()
}
