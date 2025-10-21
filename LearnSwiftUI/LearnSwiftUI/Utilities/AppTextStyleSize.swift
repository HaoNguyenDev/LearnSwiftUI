//
//  AppTextStyleSize.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/10/25.
//


import Foundation
import SwiftUI

// Define default font sizes according to Apple Human Interface Guidelines (iOS)
// These values ​​are taken from Content Size Category: Large (default)
struct AppTextStyleSize {
    
    // Sizes for large and prominent titles
    static let largeTitle: CGFloat = 34.0  // Equivalent to .largeTitle
    static let title1: CGFloat = 28.0      // Equivalent to .title
    static let title2: CGFloat = 22.0
    static let title3: CGFloat = 20.0
    
    // Kích thước cho nội dung cơ bản
    static let headline: CGFloat = 17.0    // Usually Bold/Semibold, used for subtitles/emphasis
    static let body: CGFloat = 17.0        // Usually Regular, used for main content
    
    // Sizes for sub-elements
    static let callout: CGFloat = 16.0      // Used for important captions
    static let subhead: CGFloat = 15.0      // Used for smaller titles or subtitles
    static let footnote: CGFloat = 13.0     // Used for small/author notes
    static let caption1: CGFloat = 12.0     // Equivalent to .caption
    static let caption2: CGFloat = 11.0     // Equivalent to .caption2, smallest

    /*
    Text("Title")
    .boldStyle(theme, size: AppleTextStyleSize.largeTitle, color: theme.color.textColor)
    */
}
