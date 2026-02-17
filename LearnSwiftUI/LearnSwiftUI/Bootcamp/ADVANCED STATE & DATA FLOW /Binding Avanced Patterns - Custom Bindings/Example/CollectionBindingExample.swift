//
//  CollectionBindingExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 17/2/26.
//

import SwiftUI

struct CollectionBindingExampleParrent: View {
    @State private var items = [Item(name: "Item 1", selectedItem: false),
                                Item(name: "Item 2", selectedItem: false),
                                Item(name: "Item 3", selectedItem: false),
                                ]
    var body: some View {
        CollectionBindingExampleChild(items: $items)
        CollectionBindingExampleChild2(items: $items)
    }
}

struct CollectionBindingExampleChild: View {
    @Binding var items: [Item]
    var body: some View {
        Section("Section 1") {
            ForEach($items) { $item in
                VStack {
                    Toggle(isOn: $item.selectedItem) {
                        Text(item.name)
                    }
                    .padding()
                }
            }
        }
    }
}

struct CollectionBindingExampleChild2: View {
    @Binding var items: [Item]
    var body: some View {
        Section("Section 2") {
            ForEach($items) { $item in
                VStack {
                    Toggle(isOn: $item.selectedItem) {
                        Text(item.name)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    CollectionBindingExampleParrent()
}
