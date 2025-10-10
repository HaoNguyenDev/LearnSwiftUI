//
//  Environment+ThemeKeys.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var theme: any ThemeProtocol {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
    
    struct ThemeKey: EnvironmentKey {
        static var defaultValue: any ThemeProtocol = ThemeManager.shared.activeTheme
    }
}

