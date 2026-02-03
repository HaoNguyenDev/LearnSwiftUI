//
//  NavBackButton.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct NavBackButton: ViewModifier {
    let onTap: VoidResult?
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: {
                        onTap?()
                    })
                }
            }
    }
}

extension View {
    func defaultNavBackButton(onTap: VoidResult?) -> some View {
        modifier(NavBackButton(onTap: onTap))
    }
}
