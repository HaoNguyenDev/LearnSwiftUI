//
//  BackButton.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/8/25.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        HStack {
            Image(systemName: "arrowshape.left.fill")
                .frame(width: 25, height: 25)
        }
        .foregroundColor(Color.black)
        .padding(.leading, 10)
    }
}

#Preview {
    BackButton()
}
