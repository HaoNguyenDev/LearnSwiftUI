//
//  SelectedRowListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/1/26.
//

import SwiftUI

struct MultiSelectRowListView: View {
    private var items: [Item]
    @State private var isExpandedIDs: Set<UUID>
    
    init() {
        self.items = (0...20).map { Item(name: "Item \($0)")}
        self.isExpandedIDs = []
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items) { item in
                    ExpandableRowView(title: item.name, isExpand: isExpandedIDs.contains(item.id))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            updateStateIDs(for: item.id)
                    }
                }
            }
        }
    }
}

extension MultiSelectRowListView {
    private func updateStateIDs(for id: UUID) {
        withAnimation(.spring) {
            if isExpandedIDs.contains(id) {
                isExpandedIDs.remove(id)
            } else {
                isExpandedIDs.insert(id)
            }
        }
    }
}

struct ExpandableRowView: View {
    var title: String
    var isExpand: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
            if isExpand {
                Text("\(title) description")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .foregroundStyle((isExpand ? Color.white : Color.black))
        .background(
            isExpand ? Color.green : Color.gray
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
        
    }
}

#Preview(body: {
    MultiSelectRowListView()
})
