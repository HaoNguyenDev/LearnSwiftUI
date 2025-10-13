//
//  ThemeManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation

class ThemeManager: ObservableObject {
    @Published var activeTheme: any ThemeProtocol = DefaultTheme()
    
    @Published var isDarkEnabled: Bool = false {
        didSet {
            activeTheme = isDarkEnabled ? DarkTheme() : DefaultTheme()
        }
    }
    
    static var shared = ThemeManager()
    private init() {
        self.isDarkEnabled = activeTheme is DarkTheme
    }
}
