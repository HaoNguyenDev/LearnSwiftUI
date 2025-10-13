//
//  DarkTheme.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import Foundation

struct DarkTheme: ThemeProtocol {
    var color: any ThemeColorProtocol = DarkThemeColors()
    var font: any ThemeFontProtocol = DarkThemeFonts()
    var assets: any ThemeAssetsProtocol = DarkThemeAssets()
}

