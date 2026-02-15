//
//  TransitionVsAnimationExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/1/26.
//

import SwiftUI

struct TransitionVsAnimationExample: View {
    
    @State private var items = ["Item 0", "Item 1", "Item 2"]
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text(".transition")
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .transition(.move(edge: .bottom))
                }
                HStack {
                    Button("Add", action: {
                        addItem()
                    })
                    
                    Button("Remove") {
                        removeItem()
                    }
                }
            }
            
            VStack {
                Text(".animation")
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .transition(.move(edge: .bottom))
                }
                HStack {
                    Button("Add", action: {
                        addItem()
                    })
                    
                    Button("Remove") {
                        removeItem()
                    }
                }
            }
            .animation(.spring(), value: items)
        }
    }
    
    private func addItem() {
        items.append("Item \(items.count)")
    }
    
    private func removeItem() {
        items.removeLast()
    }
}

#Preview {
    TransitionVsAnimationExample()
}
