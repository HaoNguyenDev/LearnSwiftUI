//
//  StickyListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 19/1/26.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var selectedItem: Bool
    
    init(name: String) {
        self.name = name
        self.selectedItem = false
    }
    
    init(name: String, selectedItem: Bool) {
        self.name = name
        self.selectedItem = selectedItem
    }
}

struct SectionModel: Identifiable {
    let id = UUID()
    let header: String
    let items: [Item]
}

struct StickyHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.blue)
    }
}

struct StickyListView: View {
    let sections = [
        SectionModel(header: "Fruit", items: [
            Item(name: "Apple"),
            Item(name: "Orange"),
            Item(name: "Banana"),
            Item(name: "Grape"),
            Item(name: "Watermelon")
        ]),
        SectionModel(header: "Vegetables", items: [
            Item(name: "Carrot"),
            Item(name: "Tomato"),
            Item(name: "Potato"),
            Item(name: "Cabbage"),
            Item(name: "Water Spinach")
        ]),
        SectionModel(header: "Drinks", items: [
            Item(name: "Orange Juice"),
            Item(name: "Green Tea"),
            Item(name: "Coffee"),
            Item(name: "Fresh Milk"),
            Item(name: "Watermelon Juice")
        ]),
        SectionModel(header: "Beer", items: [
            Item(name: "Tiger"),
            Item(name: "Heniken"),
            Item(name: "Quynhon"),
            Item(name: "Saigon"),
            Item(name: "Hanoi"),
            Item(name: "333")
        ]),
        SectionModel(header: "Sweets", items: [
            Item(name: "Cookie"),
            Item(name: "Gummy Candy"),
            Item(name: "Chocolate"),
            Item(name: "Sponge Cake"),
            Item(name: "Cupcake")
        ])
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                ForEach(sections) { section in
                    Section {
                        ForEach(section.items) { item in
                            HStack {
                                Text(item.name)
                                    .padding()
                                Spacer()
                            }
                        }
                    } header: {
                        StickyHeaderView(title: section.header)
                    }
                }
            }
        }
        .padding(.vertical)
        .navigationTitle("Sticky Sections")
    }
}

#Preview {
    StickyListView()
}
