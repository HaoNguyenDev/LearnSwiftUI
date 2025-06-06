//
//  SubviewBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/6/25.
//

import SwiftUI

struct SubviewBootcamp: View {
    
    @State private var backgroundColor: Color = .blue
    
    var body: some View {
        VStack {
            Spacer()
            titleView
            ButtonView(buttonTapped: {
                #if DEBUG
                print("Button Tapped!")
                #endif
                handleTap()
            })
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
    var buttonTapped: VoidResult?
    
    var body: some View {
        Button {
            buttonTapped?()
        } label: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.yellow)
                .frame(width: 200, height: 50)
                .overlay(
                    Text("Tap Me")
                        .font(.headline)
                        .foregroundColor(.black)
                )
        }

    }
}
