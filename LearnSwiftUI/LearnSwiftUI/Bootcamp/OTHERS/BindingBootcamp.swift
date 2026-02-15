//
//  BindingBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/6/25.
//

import SwiftUI

struct BindingBootcamp: View {
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var message: String = "....."
    @State private var isEnabled: Bool = false
    var body: some View {
        VStack {
            InputView(name: $name,
                      age: $age,
                      message: $message,
                      isEnabled: $isEnabled,
                      buttonTapped: {
                print(name, age)
                message = "Hello, \(name)!"
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea(.all)
       
    }
}

#Preview {
    BindingBootcamp()
}

struct InputView: View {
    @Environment(\.theme) var theme
    @Binding var name: String
    @Binding var age: String
    @Binding var message: String
    @Binding var isEnabled: Bool
    let buttonTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter your name", text: $name)
                .padding()
                .background(Color.white)
                .frame(height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 10)
            
            TextField("Enter your age", text: $age)
                .padding()
                .background(Color.white)
                .frame(height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 10)
            
            Button(action: {
                buttonTapped()
            }) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(isEnabled ? Color.blue : Color.gray)
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .disabled(!isEnabled)
            
            Toggle(isOn: $isEnabled) {
                Text("Enable")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxHeight: 50)
            }
            .padding(.horizontal, 10)
            
            Text("Message: \(message)")
                .font(theme.font.bold(ofSize: 20))
                .foregroundStyle(.white)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 400)
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2)
        })
        .padding(.horizontal, 20)
        
    }
}
