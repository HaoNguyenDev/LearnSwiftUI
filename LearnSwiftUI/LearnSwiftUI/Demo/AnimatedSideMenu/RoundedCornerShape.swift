//
//  RoundedCornerShape.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 17/2/26.
//

import SwiftUI

struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    nonisolated func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
