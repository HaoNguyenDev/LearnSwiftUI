//
//  MeasureSizeView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/1/26.
//

import SwiftUI

struct MeasureSizeViewDemo: View {
    @State private var width: CGFloat = 0

    var body: some View {
        Text("Measure me")
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            width = geo.size.width
                        }
                }
            )
            .offset(x: width / 2)
    }
}

#Preview {
    MeasureSizeViewDemo()
}
