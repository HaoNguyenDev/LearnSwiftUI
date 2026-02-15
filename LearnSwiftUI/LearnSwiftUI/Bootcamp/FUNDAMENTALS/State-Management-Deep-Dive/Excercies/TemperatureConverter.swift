//
//  TemperatureConverter.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct TemperatureConverter: View {
    @State private var celsius: Double = 0
    
    private var fahrenheitBinding: Binding<Double> {
        Binding(
            get: { celsius * 9/5 + 32 },
            set: { celsius = ($0 - 32) * 5/9 }
        )
    }
    
    private var kelvinBinding: Binding<Double> {
        Binding(
            get: { celsius + 273.15 },
            set: { celsius = $0 - 273.15 }
        )
    }
    
    var body: some View {
      
            Section("Temperature") {
                HStack {
                    Text("Celsius")
                    Spacer()
                    TextField("", value: $celsius, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Fahrenheit")
                    Spacer()
                    TextField("", value: fahrenheitBinding, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Kelvin")
                    Spacer()
                    TextField("", value: kelvinBinding, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
            }
            .padding()
    }
}

#Preview {
    TemperatureConverter()
}
