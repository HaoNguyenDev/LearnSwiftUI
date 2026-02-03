//
//  GoodCalculator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct GoodCalculator: View {
    @State private var number1 = 1
    @State private var number2 = 1
    
    private var sum: Int {  // Computed, not stored
        number1 + number2
    }
    
    var body: some View {
        VStack {
            TextField("Number 1", value: $number1, format: .number)
            TextField("Number 2", value: $number2, format: .number)
            Text("Sum: \(sum)")
        }
    }
}
