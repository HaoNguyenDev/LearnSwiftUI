//
//  EquatableViewDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/1/26.
//

import SwiftUI

struct RowView: View, Equatable {
    let title: String
    let isSelected: Bool
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title && lhs.isSelected == rhs.isSelected
    }
    
    var body: some View {
        let _ = debugPrint("\(title) recompute")
        Text(title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(isSelected ? .blue : .green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
}


struct EquatableViewDemo: View {
    
    private let items: [Item]
    @State private var selectedIds: Set<UUID>
    
    init() {
        items = (0...20).map{ Item(title: "Item \($0)")}
        selectedIds = []
    }
    
    var body: some View {
        ScrollView {
            ForEach(items) { item in
                RowView(title: item.title, isSelected: selectedIds.contains(item.id))
                    .onTapGesture {
                        selectId(id: item.id)
                    }
            }
        }
    }
    
    private func selectId( id: UUID) {
        if selectedIds.contains(id) {
            selectedIds.remove(id)
        } else {
            selectedIds.insert(id)
        }
    }
}

#Preview {
    EquatableViewDemo()
}
