//
//  UserSettings.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//

import Foundation

class UserSettings: ObservableObject {
    static let shared = UserSettings()
    private init() {}
    
    var hasLoggedIn = false
    var isMaintenance = false
    var isShowLoading = false
}
