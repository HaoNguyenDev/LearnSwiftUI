//
//  StickyBottomButton.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

struct StickyBottomButton: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<20) { number in
                    Text("\(number)")
                        .padding()
                }
                TextField("TextField", text: .constant(""))
            }
            .frame(maxWidth: .infinity)
        }
        .safeAreaInset(edge: .bottom) { // stick on top of the keyboard
            Button("Button") {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.green)
        }
    }
}

#Preview {
    StickyBottomButton()
}

