//
//  TemperatureViewCustomBinding.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct TemperatureViewCustomBinding: View {
    @State private var celsius: Double = 0
    
    // Custom binding: Fahrenheit ↔ Celsius
    private var fahrenheitBinding: Binding<Double> {
        Binding(
            get: { celsius * 9/5 + 32 },
            set: { celsius = ($0 - 32) * 5/9 }
        )
    }
    
    var body: some View {
        VStack {
            TextField("Celsius", value: $celsius, format: .number)
            TextField("Fahrenheit", value: fahrenheitBinding, format: .number)
        }
    }
}
