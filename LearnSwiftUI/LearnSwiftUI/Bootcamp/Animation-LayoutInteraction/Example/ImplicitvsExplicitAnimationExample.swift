//
//  ImplicitvsExplicitAnimationExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/1/26.
//

import SwiftUI

struct ImplicitvsExplicitAnimationExample: View {
    @State private var doImplicit = false
    @State private var doExplicit = false
    
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text(doImplicit ? "Light On": "Light Off")
                Button("Implicit") {
                    doImplicit.toggle()
                }
                .buttonStyle(.bordered)
            }
            .frame(maxWidth: .infinity)
            .animation(.spring(), value: doExplicit)
            
            VStack {
                Text(doExplicit ? "Light On": "Light Off")
                Button("Explicit") {
                    withAnimation(.spring()) {
                        doExplicit.toggle()
                    }
                }
                .buttonStyle(.bordered)
            }
            .frame(maxWidth: .infinity)
        }
        
    }
}

