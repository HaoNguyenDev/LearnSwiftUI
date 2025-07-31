//
//  EnvironmentBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/7/25.
//

import Foundation
import SwiftUI

@Observable
class EnvironmentBootcampStore {
    var listItems: [AppleProduct]
    
    init() {
        self.listItems = [AppleProduct(name: "iPhone 13", price: 1000.0),
                          AppleProduct(name: "MacBook Pro", price: 2000.0),
                          AppleProduct(name: "AirPods Pro", price: 300.0),
                          AppleProduct(name: "Watch Series 7", price: 400.0),
                          AppleProduct(name: "iMac 24-inch", price: 1500.0),
                          AppleProduct(name: "iPad Pro 11-inch", price: 800.0),
                          AppleProduct(name: "Apple TV 4K", price: 300.0),
                          AppleProduct(name: "HomePod mini", price: 100.0),
                          AppleProduct(name: "Mac mini (M2)", price: 900.0),
                          AppleProduct(name: "iMac 27-inch", price: 1800.0),
                          AppleProduct(name: "MacBook Air (M2)", price: 900.0),
                          AppleProduct(name: "Apple Watch Series 6", price: 350.0),
                          AppleProduct(name: "iPad Air (5th generation)", price: 600.0),
                          AppleProduct(name: "Apple TV 3rd generation", price: 200.0),
                          AppleProduct(name: "iMac 24", price: 1500.0)]
    }
}

struct EnvironmentBootcamp: View {
    @State private var store = EnvironmentBootcampStore()
    var body: some View {
        EnvironmentSubView()
            .environment(store)
    }
}

struct EnvironmentSubView: View {
    @Environment(EnvironmentBootcampStore.self) var store
    
    var body: some View {
        VStack {
            ForEach(store.listItems) { product in
                Text("\(product.name) - \(product.price)")
            }
        }
    }
}

#Preview {
    EnvironmentBootcamp()
}
