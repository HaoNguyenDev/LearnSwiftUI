//
//  MVVMDemoUIKitContentView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 19/10/25.
//


import SwiftUI

struct MVVMDemoUIKitContentView: View {
    var body: some View {
        VStack {
            MVVMDemoUIKitViewWrapper()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
