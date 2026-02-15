//
//  CustomCard.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

struct CustomCardWithViewBuilder<Content: View>: View {
    let content: Content 

    // Use @ViewBuilder for initializer 
    init(@ViewBuilder content: () -> Content) { 
        self.content = content() 
    } 

    var body: some View { 
        VStack { 
            content
        } 
        .padding() 
        .background(Color.gray.opacity(0.2)) 
        .cornerRadius(10) 
    }
}
