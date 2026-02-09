//
//  OrderMattersDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/2/26.
//

import SwiftUI

struct OrderMattersDemo: View {
    var body: some View {
        VStack(spacing: 30) {
            // Case 1: Background first, padding later
            Text("Hello")
                .background(Color.blue)
                .padding()
            // → Blue background, white padding
            
            // Case 2: Padding first, background later
            Text("Hello")
                .padding()
                .background(Color.blue)
            // → Blue background extends to padding
            
            // Case 3: Multiple backgrounds
            Text("Hello")
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.red)
            // → Nested backgrounds
        }
    }
}
