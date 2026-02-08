//
//  StyledContainerExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/2/26.
//

import SwiftUI

struct StyledContainerExample<Content: View>: View {
    
    enum Style {
        case primary, secondary, danger
        
        var boderColor: Color {
            switch self {
            case .primary: return .blue
            case .secondary: return .gray
            case .danger: return .red
            }
        }
        
        var textColor: Color {
            switch self {
            case .primary: return .black
            case .secondary: return .secondary
            case .danger: return .red
            }
        }
    }
    
    let style: Style
    let content: Content
    
    init(style: Style = .primary, @ViewBuilder content: () -> Content) {
        self.style = style
        self.content = content()
    }
    
    var body: some View {
        content
            .foregroundStyle(style.textColor)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style.boderColor, lineWidth: 2)
            )
    }
}

#Preview {
    StyledContainerExample(style: .danger) {
        Text("Error!")
        Text("Something went wrong!")
    }
    
    StyledContainerExample(style: .primary) {
        Text("Welcome!")
        Text("Let's style with me!")
    }
}
