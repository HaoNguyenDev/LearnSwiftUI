//
//  SplitViewBuilder.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/2/26.
//

import SwiftUI

struct SplitViewBuilder<Leading: View, Trailing: View>: View {
    let leading: Leading
    let trailing: Trailing
    
    init(
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    var body: some View {
        HStack {
            leading
                .frame(maxWidth: .infinity)
            Divider()
            trailing
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    SplitViewBuilder {
        Text("Left")
        Text("Side")
    } trailing: {
        Text("Right")
        Text("Side")
    }
}
