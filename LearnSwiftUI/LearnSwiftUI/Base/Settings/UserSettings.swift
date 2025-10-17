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
}

@Observable final class UserSettings {
    static let shared = UserSettings()
    
    let keychain = KeychainManager.shared
    
    private init() {
        let initialIsDarkMode = defaults.value(forKey: UserSettingKeys.isDarkMode) as? Bool ?? false
        isDarkMode = initialIsDarkMode
        // Sync theme value with ThemeManager
        ThemeManager.shared.isDarkEnabled = initialIsDarkMode
    }
    
    private let defaults = UserDefaults.standard
    
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
            guard let newValue = newValue else { return }
            saveValueToKeychain(newValue, for: .token)
        }
    }
    
    var username: String? {
        get {
            loadValueFromKeychain(for: .username)
        }
        set {
            guard let newValue = newValue else { return }
            saveValueToKeychain(newValue, for: .username)
        }
    }
    
    var languageCode: String? {
        didSet {
            defaults.set(languageCode, forKey: UserSettingKeys.languageCode)
        }
    }
    
    var isDarkMode: Bool {
        didSet {
            defaults.set(isDarkMode, forKey: UserSettingKeys.isDarkMode)
            ThemeManager.shared.isDarkEnabled = isDarkMode
        }
    }
    
}

extension UserSettings {
    private func loadValueFromKeychain(for key: KeychainManager.KeychainKeys) -> String? {
        var result: String?
        do {
            result = try keychain.loadValueFromKeychain(for: key)
        } catch {
            Logger.shared.debug("Error when load value from keychain: \(error.localizedDescription)")
        }
        return result
    }
    
    private func saveValueToKeychain(_ value: String, for key: KeychainManager.KeychainKeys) {
        do {
            try keychain.saveValueToKeychain(value, for: key)
        } catch {
            Logger.shared.debug("Error when save value to keychain: \(error.localizedDescription)")
        }
    }
}

extension UserSettings {
    func clearUserDatas() {
        token = nil
        username = nil
    }
}
