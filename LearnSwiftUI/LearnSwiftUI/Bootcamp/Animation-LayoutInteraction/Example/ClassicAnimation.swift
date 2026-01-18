//
//  ClassicAnimation.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/1/26.
//

import SwiftUI

struct ClassicAnimation: View {
    @State private var expanded = false
    
    var body: some View {
        VStack(alignment: .center) {
            if expanded {
                Text("Hello SwiftUI")
            }
            Button(expanded ? "Hide" : "Show") {
                expanded.toggle()
            }
            .buttonStyle(.bordered)
        }
        .animation(.easeInOut, value: expanded)
    }
}
