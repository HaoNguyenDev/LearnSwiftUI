//
//  ForEachAndLoopsBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/6/25.
//

import SwiftUI

struct ForEachAndLoopsBootcamp: View {
    
    private var numbers: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(numbers, id: \.self) { value in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.green)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text("\(value)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            )
                    }
                }
            }
            .padding()
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    ForEach(numbers, id: \.self) { value in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.green)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text("\(value)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            )
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ForEachAndLoopsBootcamp()
}
