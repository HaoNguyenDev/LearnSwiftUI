//
//  SubviewBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/6/25.
//

import SwiftUI

struct SubviewBootcamp: View {
    
    @State private var backgroundColor: Color = .blue
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            titleView
            ButtonView(title: "Change background color",
                       buttonColor: .green,
                       buttonTapped: {
#if DEBUG
                print("Button Tapped!")
#endif
                handleTap()
            })
            
            InputFieldView(string: $inputText)
                .padding(.horizontal, 40)
            
            ButtonView(title: "Print text") {
                print(inputText)
            }
            
            Text("\(inputText)")
                .font(.caption)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        
    }
    
    private var titleView: some View {
        Text("Title")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
    
    private func handleTap() {
        backgroundColor = Bool.random() ? .red : .blue
    }
}

#Preview {
    SubviewBootcamp()
}

struct ButtonView: View {
    
    var title: String?
    var buttonColor: Color?
    var titleColor: Color? = .black
    var buttonTapped: VoidResult?
    
    var body: some View {
        Button {
            buttonTapped?()
        } label: {
            RoundedRectangle(cornerRadius: 8)
                .fill(buttonColor ?? Color.yellow)
                .frame(width: 200, height: 50)
                .overlay(
                    Text(title ?? "Tap Me!")
                        .font(.headline)
                        .foregroundColor(titleColor)
                )
        }

    }
}

struct InputFieldView: View {
    
    @Binding var string: String
    
    var body: some View {
        VStack {
            TextField("Enter something here...", text: $string)
                .padding()
                .background(Color.white)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .cornerRadius(8)
        }
    }
}
