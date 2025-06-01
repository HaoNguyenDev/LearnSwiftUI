//
//  ColorsBootCamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

struct ColorsBootCamp: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.customBackground)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Text("Helloooooo")
                    .font(.dosis(fontStyle: .body, fontweight: .bold, size: 20.0))
                    .foregroundColor(.customTextColor)
                    .padding()
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 300, height: 400)
                    .shadow(color: Color.black,
                            radius: 10,
                            x: 10,
                            y: 30)
            }
        }
        .ignoresSafeArea(.all)
        
        
        
    }
}

#Preview {
    ColorsBootCamp()
}
