//
//  DemoRedrawList.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/1/26.
//

import SwiftUI

struct DemoRedrawList: View {
    
    private var items: [Item]
    @State private var selectedIds: Set<UUID>
    
    init() {
        self.items = (0...100).map { Item(name: "Item \($0)")}
        self.selectedIds = []
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                DemoRow(title: item.name, isSelected: selectedIds.contains(item.id))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        updateSelectedIds(item.id)
                    }
            }
        }
    }
    
    private func updateSelectedIds(_ id: UUID) {
        withAnimation(.linear) {
            if selectedIds.contains(id) {
                selectedIds.remove(id)
            } else {
                selectedIds.insert(id)
            }
        }
    }
}

struct DemoRow: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(isSelected ? Color.blue : Color.red)
    }
}


#Preview {
    DemoRedrawList()
}
