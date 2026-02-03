//
//  ColorPickerExercise.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct ColorPickerExercise: View {
    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    
    private var color: Color {
        Color(red: red, green: green, blue: blue)
    }
    
    private var hexCode: String {
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .fill(color)
                .frame(height: 200)
                .cornerRadius(12)
            
            Text(hexCode)
                .font(.system(.title, design: .monospaced))
            
            ColorSlider(value: $red, color: .red, label: "Red")
            ColorSlider(value: $green, color: .green, label: "Green")
            ColorSlider(value: $blue, color: .blue, label: "Blue")
        }
        .padding()
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    let color: Color
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(label): \(Int(value * 255))")
                .font(.caption)
            Slider(value: $value, in: 0...1)
                .accentColor(color)
        }
    }
}

#Preview {
    ColorPickerExercise()
}
