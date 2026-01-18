//
//  JumpAnimationBehaviorExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/1/26.
//

import SwiftUI

struct JumpAnimationBehaviorExample: View {
    @State private var expanded = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Title")
            if expanded {
                Text("Detail")
            }
            Button(expanded ? "Hide" : "Show") {
                expanded.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
}
