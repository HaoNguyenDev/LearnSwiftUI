//
//  StickyListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 19/1/26.
//

import SwiftUI

struct Item: Identifiable {
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
    let geometry: GeometryProxy
    
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
                            GeometryReader { geo in
                                HStack {
                                    Text(item.title)
                                        .padding()
                                    Spacer()
                                }
                                .background(Color.white)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color.gray.opacity(0.3)),
                                    alignment: .bottom
                                )
                            }
                            .frame(height: 50)
                        }
                    } header: {
                        GeometryReader { geo in
                            StickyHeaderView(title: section.header, geometry: geo)
                        }
                        .frame(height: 50)
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
