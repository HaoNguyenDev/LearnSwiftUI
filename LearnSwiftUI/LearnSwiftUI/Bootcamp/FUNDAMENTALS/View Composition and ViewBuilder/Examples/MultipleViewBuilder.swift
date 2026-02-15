//
//  MultipleViewBuilder.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/2/26.
//

import SwiftUI

struct MultipleViewBuilder<Header: View, Content: View, Footer: View>: View {
    
    let header: Header
    let content: Content
    let footer: Footer
    
    init(@ViewBuilder header: () -> Header,
         @ViewBuilder content: () -> Content,
         @ViewBuilder footer: () -> Footer) {
        self.header = header()
        self.content = content()
        self.footer = footer()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color.gray.opacity(0.1))
            
            ScrollView {
                content
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            footer
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color.white)
                .shadow(radius: 4)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MultipleViewBuilder {
        Text("Title")
    } content: {
        Text("Body")
        Text("Content")
    } footer: {
        Button("Save") { }
    }
}
