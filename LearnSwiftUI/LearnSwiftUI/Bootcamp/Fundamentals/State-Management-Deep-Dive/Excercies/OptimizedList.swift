//
//  OptimizedList.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct OptimizedList: View {
    @State private var items = Array(1...20).map { Item(name: "Item \($0)") }
    @State private var filterText = ""
    @State private var debouncedFilter = ""
    @State private var filterTask: Task<Void, Never>?
    
    private var filteredItems: [Item] {
        guard !debouncedFilter.isEmpty else { return items }
        return items.filter { $0.name.localizedCaseInsensitiveContains(debouncedFilter) }
    }
    
    var body: some View {
        VStack {
            TextField("Filter", text: $filterText)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onChange(of: filterText) { _, newValue in
                    filterTask?.cancel()
                    filterTask = Task {
                        try? await Task.sleep(nanoseconds: 300_000_000) // 300ms debounce
                        if !Task.isCancelled {
                            debouncedFilter = newValue
                        }
                    }
                }
            
            ScrollView {
                LazyVStack {
                    ForEach(filteredItems, id: \.id) { item in
                        ItemRow(item: item)
                    }
                }
            }
        }
    }
}

struct ItemRow: View {
    let item: Item
    
    var body: some View {
        Text(item.name)
    }
}
