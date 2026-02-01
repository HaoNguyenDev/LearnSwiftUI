//
//  ItemListViewIdentityTest.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

// 3. IDENTITY in List
struct ItemListViewIdentityTest: View {
    let items = ["A", "B", "C"]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .background(FillShapeStyle())
                }
            }
        }
    }
}
// SwiftUI tracks each item by id

#Preview {
    ItemListViewIdentityTest()
}
