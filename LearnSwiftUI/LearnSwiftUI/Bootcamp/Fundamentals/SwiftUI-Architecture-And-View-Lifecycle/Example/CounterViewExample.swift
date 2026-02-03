//
//  CounterViewExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

struct CounterViewExample: View {
    @State private var count = 0
    
    init() {
        debugPrint("🏗️ View struct created")
        // Called MANY times - every render time!
    }
    
    var body: some View {
        debugPrint("🎨 Body evaluated")
        return VStack {
            Text("Count: \(count)")
            Button("Increment") {
                count += 1
            }
            .buttonStyle(.bordered)
        }
    }
}

// Output when running:
// 🏗️ View struct created
// 🎨 Body evaluated
// [User clicks button]
// 🏗️ View struct created ← Create again!
// 🎨 Body evaluated

#Preview { CounterViewExample() }
