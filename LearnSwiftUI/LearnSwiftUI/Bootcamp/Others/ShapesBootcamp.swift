//
//  ShapesBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

struct ShapesBootcamp: View {
    var body: some View {
//        Circle()
//        ContainerRelativeShape()
//        Capsule(style: .circular)
//        Rectangle()
        RoundedRectangle(cornerRadius: 20.0)
            .fill(Color.red)
//            .stroke(Color.blue, lineWidth: 10)
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 3.0, lineCap: .round, dash: [10.0]))
            .padding(20.0)
            .frame(width: 300.0, height: 200.0)
    }
}

#Preview {
    ShapesBootcamp()
}
