//
//  DefaultTheme.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation

struct DefaultTheme: ThemeProtocol {
    var color: ThemeColorProtocol = DefaultThemeColor()
    var font: ThemeFontProtocol = DefaultThemeFont()
    var assets: ThemeAssetsProtocol = DefaultThemeAssets()
}
