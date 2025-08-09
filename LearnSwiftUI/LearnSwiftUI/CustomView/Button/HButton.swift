//
//  HButton.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/8/25.
//

import SwiftUI

struct HButton: View {
    enum Style {
        case primary
        case secondary
        case destructive
        case ghost
    }
    
    enum Size {
        case small
        case regular
        case large
    }
    
    private let title: String
    private let style: Style
    private let size: Size
    private let isLoading: Bool
    private let action: () -> Void
    
    init(
        _ title: String,
        style: Style = .primary,
        size: Size = .regular,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.isLoading = isLoading
        self.action = action
    }
}

extension HButton {
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(0.8)
                }
                Text(title)
                    .font(fontForSize)
                    .fontWeight(fontWeightForStyle)
            }
            .foregroundStyle(foregroundColorForStyle)
            .padding(10)
            .background(backgroundColorForStyle)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadiusForStyle))
        }
        .disabled(isLoading)
        .opacity(isLoading ? 0.5 : 1.0)
    }
}

#Preview {
    HButton("Login", style: .primary, size: .large, isLoading: false) {
        
    }
}

extension HButton {
    var fontForSize: Font {
        switch size {
        case .small:
            return .dosis(fontweight: .bold, size: 18.0)
        case .regular:
            return .dosis(fontweight: .regular, size: 18.0)
        case .large:
            return .dosis(fontweight: .regular, size: 20.0)
        }
    }
    
    var fontWeightForStyle: Font.Weight {
        switch style {
        case .primary, .destructive: return .semibold
        case .secondary, .ghost: return .medium
        }
    }
    
    var foregroundColorForStyle: Color {
        switch style {
        case .primary: return .white
        case .secondary: return .black
        case .destructive: return .white
        case .ghost: return .clear
        }
    }
    
    var backgroundColorForStyle: Color {
        switch style {
        case .primary: return .blue
        case .secondary: return .white
        case .destructive: return .red
        case .ghost: return .clear
        }
    }
    
    var cornerRadiusForStyle: CGFloat {
        switch style {
        case .primary, .destructive: return 10
        case .secondary, .ghost: return 5
        }
    }
}
