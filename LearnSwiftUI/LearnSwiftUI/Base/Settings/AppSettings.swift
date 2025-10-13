//
//  AppSettings.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import SwiftUI

@Observable final class AppSettings {
    static let shared = AppSettings()
    
    let isMaintenance = false
    private init() {}
}
