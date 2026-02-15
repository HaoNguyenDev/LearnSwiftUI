//
//  SharedStateExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct SharedStateExample: View {
    @State private var number: Int = 0
    
    var body: some View {
        VStack {
            SharedStateDisplayExample(title: $number)
            SharedStateCountButtonExample(number: $number)
        }
    }
}

struct SharedStateDisplayExample: View {
    @Binding var title: Int
    var body: some View {
        VStack {
            Text("\(title)")
        }
        .padding()
        .background(.green)
    }
}


struct SharedStateCountButtonExample: View {
    @Binding var number: Int
    var body: some View {
        VStack {
            Button("Increase") {
                debugPrint("Increase")
                number += 1
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    SharedStateExample()
}
