//
//  HStackAlignment.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/2/26.
//

import SwiftUI

struct HStackAlignment: View {
    var body: some View {
        VStack(spacing: 20) {
            // Top alignment
            HStack(alignment: .top) {
                Text("Top")
                    .font(.largeTitle)
                Text("aligned")
                    .font(.caption)
            }
            
            // Center (default)
            HStack(alignment: .center) {
                Text("Center")
                    .font(.largeTitle)
                Text("aligned")
                    .font(.caption)
            }
            
            // Bottom alignment
            HStack(alignment: .bottom) {
                Text("Bottom")
                    .font(.largeTitle)
                Text("aligned")
                    .font(.caption)
            }
        }
    }
}
