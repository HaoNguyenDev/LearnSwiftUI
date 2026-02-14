//
//  DragViewDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/1/26.
//

import SwiftUI

struct DragViewDemo: View {
    @State private var translation: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .frame(width: geo.size.width * 0.8, height: 200)
                .offset(x: translation)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            translation = value.translation.width
                        }
                )
        }
    }
}

#Preview {
    DragViewDemo()
}
