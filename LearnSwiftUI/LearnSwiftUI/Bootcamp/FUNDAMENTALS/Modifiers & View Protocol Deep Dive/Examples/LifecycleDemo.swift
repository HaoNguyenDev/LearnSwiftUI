//
//  LifecycleDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/2/26.
//

import SwiftUI

struct LifecycleDemo: View {
    @State private var counter = 0
    
    init() {
        print("1. Init called")
    }
    
    var body: some View {
        debugPrint("2. Body computed")
        return VStack {
            Text("Counter: \(counter)")
            Button("Increment") {
                counter += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            print("3. OnAppear called")
        }
    }
}
