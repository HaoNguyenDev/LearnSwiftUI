//
//  StickyListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 19/1/26.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    let id = UUID()
    let title: String
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
            Item(title: "Apple"),
            Item(title: "Orange"),
            Item(title: "Banana"),
            Item(title: "Grape"),
            Item(title: "Watermelon")
        ]),
        SectionModel(header: "Vegetables", items: [
            Item(title: "Carrot"),
            Item(title: "Tomato"),
            Item(title: "Potato"),
            Item(title: "Cabbage"),
            Item(title: "Water Spinach")
        ]),
        SectionModel(header: "Drinks", items: [
            Item(title: "Orange Juice"),
            Item(title: "Green Tea"),
            Item(title: "Coffee"),
            Item(title: "Fresh Milk"),
            Item(title: "Watermelon Juice")
        ]),
        SectionModel(header: "Beer", items: [
            Item(title: "Tiger"),
            Item(title: "Heniken"),
            Item(title: "Quynhon"),
            Item(title: "Saigon"),
            Item(title: "Hanoi"),
            Item(title: "333")
        ]),
        SectionModel(header: "Sweets", items: [
            Item(title: "Cookie"),
            Item(title: "Gummy Candy"),
            Item(title: "Chocolate"),
            Item(title: "Sponge Cake"),
            Item(title: "Cupcake")
        ])
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                ForEach(sections) { section in
                    Section {
                        ForEach(section.items) { item in
                            HStack {
                                Text(item.title)
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
