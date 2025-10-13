//
//  ThemeManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import SwiftUI

@Observable class ThemeManager {
    static var shared = ThemeManager()
    
    var activeTheme: any ThemeProtocol = DefaultTheme()
    
    var isDarkEnabled: Bool = false {
        didSet {
            activeTheme = isDarkEnabled ? DarkTheme() : DefaultTheme()
             Logger.shared.debug("ThemeManager activeTheme updated: \(activeTheme)")
        }
    }
    
    private init() {}
}
