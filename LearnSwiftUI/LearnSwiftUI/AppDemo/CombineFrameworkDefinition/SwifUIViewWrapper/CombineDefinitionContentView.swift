//
//  CombineDefinitionContentView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/10/25.
//


import SwiftUI

struct CombineDefinitionContentView: View {
    var body: some View {
        VStack {
            
            CombineDefinitionViewWrapper()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
