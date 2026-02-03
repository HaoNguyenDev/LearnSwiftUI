//
//  CounterExercise.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

// TODO: Implement a simple counter with increment, decrement, reset

// Requirements:
// 1. Counter must be silent
// 2. Reset to 0
// 3. Display "Even" or "Odd"

import SwiftUI

struct CounterExercise: View {
    @State private var number = 0
    
    private var counterType: String {
        number.isMultiple(of: 2) ? "Even" : "Odd"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(number)")
                .font(.system(size: 60, weight: .bold))
            
            Text(counterType)
                .font(.title)
                .foregroundColor(.secondary)

            HStack(spacing: 16) {
                Button("Decrease") {
                    number -= 1
                }
                .disabled(number == 0)
                
                Button("Increment") {
                    number += 1
                }
                
                Button("Reset") {
                    number = 0
                }
                .opacity(number == 0 ? 0.5 : 1)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    CounterExercise()
}
