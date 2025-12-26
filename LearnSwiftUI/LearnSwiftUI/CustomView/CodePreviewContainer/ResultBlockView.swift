//
//  ResultBlockView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/12/25.
//

import SwiftUI

struct ResultBlockView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }
}
