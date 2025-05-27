//
//  IconsBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

struct IconsBootcamp: View {
    @State private var isTapped: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "gamecontroller.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(isTapped ? .red : .blue)
                .scaleEffect(isTapped ? 1.5 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: isTapped)
                .onTapGesture {
                    isTapped.toggle()
                }
            
            Text("Tap to interact!")
                .font(.title2)
                .foregroundColor(.customTextColor)
                .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    IconsBootcamp()
}
