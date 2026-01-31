//
//  TimelineAnimationExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/1/26.
//

import SwiftUI

struct TimelineAnimationExample: View {
    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSince1970
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(t * 360))
                .overlay {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 5)
                        .rotationEffect(.degrees(t * 60))
                        .padding()
                }
        }
        .padding()
    }
}

#Preview {
    TimelineAnimationExample()
}
