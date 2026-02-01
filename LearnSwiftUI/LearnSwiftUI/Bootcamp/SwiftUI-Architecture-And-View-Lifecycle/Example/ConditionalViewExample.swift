//
//  ConditionalViewExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

// 1. STRUCTURAL IDENTITY (default)
struct ConditionalViewExample: View {
    @State private var showRed = true
    
    var body: some View {
        debugPrint("🎨 ConditionalViewExample Body evaluated")
        return VStack {
            if showRed {
                CustomCircleViewIdentityTest(.red) // Identity = position in tree
                    .frame(height: 100)
            } else {
                CustomCircleViewIdentityTest(.blue) // DIFFERENT identity!
                    .frame(height: 100)
            }
            
            Button("Toggle") {
                showRed.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
}
// When toggle: Red circle destroyed, Blue circle created

struct CustomCircleViewIdentityTest: View {
    @State private var viewID = UUID()
    var background: Color
    
    init(_ background: Color) {
        debugPrint("🏗️ CustomCircleViewIdentityTest View struct created")
        // Called every render time!
        self.background = background
    }

    var body: some View {
        debugPrint("🎨 CustomCircleViewIdentityTest Body evaluated")
        return Circle()
            .fill(background)
            .overlay {
                Text("\(viewID)")
            }
    }
}
