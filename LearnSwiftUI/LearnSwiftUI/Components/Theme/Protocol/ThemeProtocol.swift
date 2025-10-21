//
//  ThemeProtocol.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation

protocol ThemeProtocol {
    var color: ThemeColorProtocol { get }
    var font: ThemeFontProtocol { get }
    var assets: ThemeAssetsProtocol { get }
}
