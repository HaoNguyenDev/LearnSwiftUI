//
//  BackButton.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/8/25.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.theme) var theme
    
    var body: some View {
        HStack {
            Image(R.image.ic_back)
                .frame(width: 25, height: 25)
        }
        .foregroundColor(theme.color.textBlack)
        .padding(.leading, 0)
    }
}

#Preview {
    BackButton()
}
