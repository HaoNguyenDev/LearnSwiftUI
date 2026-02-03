//
//  CustomNavigationTitle.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct CustomNavigationTitle: ViewModifier {
    let title: String
    let subtitle: String?
    let titleColor: [Color]
    let subtitleColor: Color
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(title)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: titleColor,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.caption)
                                .foregroundColor(subtitleColor)
                        }
                    }
                }
            }
    }
}

extension View {
    func customNavigationTitle(
        _ title: String,
        subtitle: String? = nil,
        titleColors: [Color]? = nil,
        subtitleColor: Color? = nil
    ) -> some View {
        modifier(CustomNavigationTitle(title: title,
                                       subtitle: subtitle,
                                       titleColor: titleColors ?? [.black, .gray],
                                       subtitleColor: subtitleColor ?? .gray))
    }
}
