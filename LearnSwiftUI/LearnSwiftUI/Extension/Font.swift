//
//  Font.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import Foundation
import SwiftUI

extension Font {
    static func dosis(fontStyle: Font.TextStyle = .body,
                            fontweight: Font.Weight = .regular,
                            size: CGFloat) -> Font {
        Font.custom(Dosis(weight: fontweight).rawValue, size: size)
    }
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .body:
            return 17
        case .caption:
            return 13
        case .footnote:
            return 12
        case .headline:
            return 34
        case .subheadline:
            return 21
        case .title:
            return 27
        case .largeTitle:
            return 34
        default:
            return 17
        }
    }
}


enum Dosis: String {
    case regular = "Dosis-Regular"
    case light = "Dosis-Light"
    case medium = "Dosis-Medium"
    case semiBold = "Dosis-SemiBold"
    case bold = "Dosis-Bold"
    case extraBold = "Dosis-ExtraBold"
    
    init(weight: Font.Weight) {
        switch weight {
        case .light:
            self = .light
        case .medium:
            self = .medium
        case .semibold:
            self = .semiBold
        case .bold:
            self = .bold
        default:
            self = .regular
        }
    }
}
