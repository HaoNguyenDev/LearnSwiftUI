//
//  FormView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/8/25.
//

import SwiftUI

#Preview {
    FormView()
}

struct FormView: View {
    @State private var username: String = ""
    @State private var enableNotification: Bool = false
    @State private var selectedColor: String = ""
    @State private var age = 18
    @State private var accentColor: Color = .blue
    var colors = ["blue", "green", "yellow", "red"]
    
    var body: some View {
        Form {
            account()
            general()
            picker()
            stepper()
        }
    }
}

extension FormView {
    @ViewBuilder
    func account() -> some View {
        Section("Account") {
            TextField("Username", text: $username)
            
            Toggle(isOn: $enableNotification) {
                Text("Enable notification")
            }
        }
    }
    
    @ViewBuilder
    func general() -> some View {
        Section("General") {
            Button("Change password") {
                
            }.buttonStyle(.borderedProminent)
            
            Toggle(isOn: $enableNotification) {
                Text("Enable notification")
            }
        }
    }
    
    @ViewBuilder
    func picker() -> some View {
        Section("Picker") {
            Picker("Choose color", selection: $selectedColor) {
                ForEach(colors, id: \.self) { color in
                    Text(color)
                }
            }
            
            ColorPicker("Accent Color", selection: $accentColor)
            
            Capsule().fill(accentColor)
                .frame(width: 100, height: 50)
        }
    }
    
    @ViewBuilder
    func stepper() -> some View {
        Section("Stepper") {
            VStack(spacing: 20) {
                Stepper("Tuổi: \(age)", value: $age, in: 1...100)
            }
        }
    }
}
