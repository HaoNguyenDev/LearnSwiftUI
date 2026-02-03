//
//  BackButton.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/8/25.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.theme) var theme
    
    let action: VoidResult?
    
    init(action: VoidResult? = nil) {
        self.action = action
    }
    
    var body: some View {
        HStack {
            Image(R.image.ic_back)
                .frame(width: 40, height: 40, alignment: .leading)
        }
        .foregroundColor(theme.color.textBlack)
        .padding(.leading, 0)
        .onTapGesture {
            action?()
        }
    }
}

#Preview {
    BackButton()
}
