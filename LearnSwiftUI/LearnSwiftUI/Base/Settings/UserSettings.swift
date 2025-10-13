//
//  UserSettings.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import Foundation

extension UserSettings {
    // MARK: - Keys
    private enum UserSettingKeys {
        static let token = "token"
        static let languageCode = "languageCode"
        static let isDarkMode = "isDarkMode"
    }
}

@Observable final class UserSettings {
    static let shared = UserSettings()
    
    private init() {
        let initialIsDarkMode = defaults.value(forKey: UserSettingKeys.isDarkMode) as? Bool ?? false
        isDarkMode = initialIsDarkMode
        // Sync theme value with ThemeManager
        ThemeManager.shared.isDarkEnabled = initialIsDarkMode
    }
    
    private let defaults = UserDefaults.standard
    
    var hasLoggedIn: Bool {
        get {
            return token != nil && token != ""
        }
    }
    
    var token: String? {
        didSet {
            defaults.set(token, forKey: UserSettingKeys.token)
        }
    }
    
    var languageCode: String? {
        didSet {
            Logger.shared.info("languageCode set to: \(languageCode ?? "nil")")
            defaults.set(languageCode, forKey: UserSettingKeys.languageCode)
        }
    }
    
    var isDarkMode: Bool {
        didSet {
            defaults.set(isDarkMode, forKey: UserSettingKeys.isDarkMode)
            ThemeManager.shared.isDarkEnabled = isDarkMode
            Logger.shared.debug("isDarkEnabled: \(isDarkMode)")
        }
    }
    
}

extension UserSettings {
    func clearUserDatas() {
        token = nil
    }
}
