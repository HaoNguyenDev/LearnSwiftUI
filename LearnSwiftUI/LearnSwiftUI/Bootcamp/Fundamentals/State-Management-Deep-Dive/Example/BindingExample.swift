//
//  BindingExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct BindingExample: View {
    @State private var parentToggleValue: Bool = false
    
    var body: some View {
        VStack {
            Text("Parent View")
                .padding()
            Toggle(isOn: $parentToggleValue) {
                Text("Toggle")
            }
            .padding()
            BindingChildViewExample(childToggleValue: $parentToggleValue)
                .padding()
            Spacer()
                .frame(height: 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
        )
    }
}

struct BindingChildViewExample: View {
    @Binding var childToggleValue: Bool
    
    var body: some View {
        VStack {
            Text("Child View")
            Toggle(isOn: $childToggleValue) {
                Text("Toggle")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.green)
        )
    }
}

#Preview {
    BindingExample()
}
