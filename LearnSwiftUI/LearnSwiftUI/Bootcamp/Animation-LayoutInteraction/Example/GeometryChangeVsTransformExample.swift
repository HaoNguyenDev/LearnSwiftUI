//
//  GeometryChangeVsTransformExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/1/26.
//

import SwiftUI

struct GeometryChangeVsTransformExample: View {
    @State private var expanded = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.green)
                .frame(maxWidth: .infinity, maxHeight: expanded ? 50 : 10)
            
            Button("Expand") {
                expanded.toggle()
                debugPrint("\(expanded)")
            }
            .buttonStyle(.bordered)
            
            VStack {
                Text("Title")
                    .padding()
                if expanded {
                    Text("Detail")
                        .padding(.bottom)
                        .transition(.opacity)
                }
            }
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                
            )
            .animation(.spring, value: expanded)
        }
        .padding(20)
    }
}

#Preview {
    GeometryChangeVsTransformExample()
}
