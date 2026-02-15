//
//  StableIdentityViewExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

// 2. EXPLICIT IDENTITY with .id()
struct StableIdentityViewExample: View {
    @State private var showRed = true
    init() {
        debugPrint("🏗️ StableIdentityViewExample View struct created")
        // Called every render time!
    }
    
    var body: some View {
        debugPrint("🎨 StableIdentityViewExample Body evaluated")
        return VStack {
            CustomCircleViewIdentityTest(showRed ? .red : .blue)
//                .id(stableID) // Stable identity
                .frame(height: 100)
            Button("Toggle") {
                showRed.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
}
// When toggle: Same circle, only change color
