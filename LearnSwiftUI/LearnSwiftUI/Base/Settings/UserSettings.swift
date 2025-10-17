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
    
    private enum KeychainKeys: String, CaseIterable {
        case username = "haonguyen.LearnSwiftUI.key.username"
        case password = "haonguyen.LearnSwiftUI.key.password"
        case token = "haonguyen.LearnSwiftUI.key.token"
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
    private let keychainAccess = Keychain(service: Bundle.main.bundleIdentifier ?? "haonguyen.LearnSwiftUI")
    
    var debugLog = false
    var hasLoggedIn: Bool {
        get {
            guard let token = token else { return false }
            return token != ""
        }
    }
    
    var token: String? {
        get {
            loadValueFromKeychain(for: .token)
        }
        set {
            saveValueToKeychain(newValue, for: .token)
            Logger.shared.debug("Login success with token: \(newValue ?? "")")
        }
    }
    
    var username: String? {
        get {
            loadValueFromKeychain(for: .username)
        }
        set {
            saveValueToKeychain(newValue, for: .username)
        }
    }
    
    var languageCode: String? {
        didSet {
            Logger.shared.debug("languageCode set to: \(languageCode ?? "nil")")
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
    private func loadValueFromKeychain(for key: KeychainKeys) -> String? {
        return keychainAccess[key.rawValue]
    }
    
    private func saveValueToKeychain(_ value: String?, for key: KeychainKeys) {
        keychainAccess[key.rawValue] = value
    }
}

extension UserSettings {
    func clearUserDatas() {
        token = nil
        username = nil
    }
}
