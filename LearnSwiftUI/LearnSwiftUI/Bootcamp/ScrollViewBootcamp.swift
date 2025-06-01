//
//  ScrollViewBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/6/25.
//

import SwiftUI

struct ScrollViewBootcamp: View {
    
    private let verticalItems: [String] = ["Section 1", "Section 2", "Section 3", "Section 4", "Section 5"]
    
    private let horizontalItems: [String] = ["Horizontal Item 1", "Horizontal Item 2", "Horizontal Item 3", "Horizontal Item 4", "Horizontal Item 5"]
    
    var body: some View {
        ScrollView {
            ForEach(verticalItems, id: \.self) { section in
                LazyVStack(alignment: .leading) {
                    Text(section)
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
                    
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(horizontalItems, id: \.self) { item in
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                        .frame(width: 100, height: 100)
                                        .shadow(radius: 5)
                                        .padding(15)
                                        .overlay( Text(item)
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                        )
                                }
                            }
                            .padding(.horizontal, 1)
                        }
                       
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                }
                .frame(maxWidth: .infinity, maxHeight: 500)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ScrollViewBootcamp()
}
