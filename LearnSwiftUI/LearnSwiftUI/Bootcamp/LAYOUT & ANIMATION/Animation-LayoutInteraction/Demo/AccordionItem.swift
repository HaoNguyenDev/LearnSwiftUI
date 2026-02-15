//
//  AccordionItem.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/1/26.
//

import SwiftUI

struct AccordionItemModel: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

struct AccordionItem: View {
    let title: String
    let content: String

    @State private var expanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(expanded ? 180 : 0))
                    .animation(.easeInOut, value: expanded)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut) {
                    expanded.toggle()
                }
            }

            if expanded {
                Text(content)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct AccordionItemDemo: View {
    @State private var items: [AccordionItemModel] = [AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),
                                                      AccordionItemModel(title: "Title", content: "Content"),]
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: \.id) { item in
                    AccordionItem(title: item.title, content: item.content)
                        .padding(.top)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    AccordionItemDemo()
}
