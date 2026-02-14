//
//  PagingViewDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/1/26.
//

import SwiftUI

struct PagingViewDemo: View {
    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                ForEach(0..<3) { i in
                    Color.blue
                        .overlay(Text("Page \(i)"))
                        .frame(width: geo.size.width)
                }
            }
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let page = round(-value.translation.width / geo.size.width)
                        offset = page * -geo.size.width
                    }
            )
        }
    }
}

#Preview {
    PagingViewDemo()
}
