//
//  UserSettings.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//

import Foundation

@Observable final class UserSettings {
    static let shared = UserSettings()
    private init() {}
    
    var hasLoggedIn = false
    var isMaintenance = false
    var isShowLoading = false
}
