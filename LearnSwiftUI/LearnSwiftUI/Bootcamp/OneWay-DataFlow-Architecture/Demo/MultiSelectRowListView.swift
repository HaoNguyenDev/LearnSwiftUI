//
//  SelectedRowListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/1/26.
//

import SwiftUI

struct MultiSelectRowListView: View {
    @State private var items = (0...20).map { Item(title: "Item \($0)")}
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($items) { $item in
                    SelectableRowView(title: item.title, isOn: $item.isOn)
                        .contentShape(Rectangle())
                }
            }
        }
    }
}

struct SelectableRowView: View {
    var title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Text(title)
            .foregroundStyle((isOn ? Color.white : Color.black))
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(
                isOn ? Color.green : Color.gray
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .onTapGesture {
                isOn.toggle()
            }
    }
}

#Preview(body: {
    MultiSelectRowListView()
})
