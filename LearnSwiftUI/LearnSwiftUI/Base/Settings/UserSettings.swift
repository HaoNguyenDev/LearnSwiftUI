//
//  UserSettings.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import Foundation
import KeychainAccess

extension UserSettings {
    // MARK: - Keys
    private enum UserSettingKeys {
        static let languageCode = "languageCode"
        static let isDarkMode = "isDarkMode"
    }
    
    private enum KeychainAccessKeys {
        static let token = "token"
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
    let keychainAccess = Keychain(service: Bundle.main.bundleIdentifier ?? "")
    
    var hasLoggedIn: Bool {
        get {
            guard let token = token else { return false }
            return token != ""
        }
    }
    
    var token: String? {
        get {
            keychainAccess[KeychainAccessKeys.token]
        }
        set {
            keychainAccess[KeychainAccessKeys.token] = newValue
            Logger.shared.info("Login success with token: \(newValue ?? "")")
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
