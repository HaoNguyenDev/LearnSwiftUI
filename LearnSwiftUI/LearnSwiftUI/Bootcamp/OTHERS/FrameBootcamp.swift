//
//  FrameBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/5/25.
//

import SwiftUI

struct FrameBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(Color.blue)
//            .frame(width: 300, height: 200, alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
            .background(Color.red)
    }
}

#Preview {
    FrameBootcamp()
}
