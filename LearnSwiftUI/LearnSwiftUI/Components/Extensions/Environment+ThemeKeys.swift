//
//  Environment+ThemeKeys.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation
import SwiftUI

private struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: any ThemeProtocol = DefaultTheme()
}

extension EnvironmentValues {
    var theme: any ThemeProtocol {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}
