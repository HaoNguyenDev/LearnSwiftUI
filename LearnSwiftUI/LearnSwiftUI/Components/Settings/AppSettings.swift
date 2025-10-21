//
//  AppSettings.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import SwiftUI

@Observable final class AppSettings {
    static let shared = AppSettings()
    
    private init() {
        enableLogger = Logger.shared.isEnabled
    }
    
    let isMaintenance = false
    var enableLogger: Bool {
        didSet {
            Logger.shared.isEnabled = enableLogger
        }
    }
}
