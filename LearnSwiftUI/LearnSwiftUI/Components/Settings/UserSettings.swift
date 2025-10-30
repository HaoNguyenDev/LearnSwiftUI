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
    private let defaults = UserDefaults.standard
    private let keychain = KeychainService.shared
    private var _token: String? = nil
    private var _username: String? = nil
    
    private init() {
        let initialIsDarkMode = defaults.value(forKey: UserSettingKeys.isDarkMode) as? Bool
        isDarkMode = initialIsDarkMode ?? false
        // Sync theme value with ThemeManager
        ThemeManager.shared.isDarkEnabled = initialIsDarkMode ?? false
        
        Task {
            _token = await loadValueFromKeychain(for: .token)
            _username = await loadValueFromKeychain(for: .username)
        }
    }
    
    var debugLog = false
    
    var hasLoggedIn: Bool {
        get {
            guard let token = token else { return false }
            return token != ""
        }
    }
    
    var token: String? {
        get {
            return _token
        }
        set {
            _token = newValue
            Task {
                await saveValueToKeychain(newValue, for: .token)
            }
        }
    }
    
    var username: String? {
        get {
            return _username
        }
        set {
            _username = newValue
            Task {
                await saveValueToKeychain(newValue, for: .username)
            }
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
    
    @MainActor
    private func loadValueFromKeychain(for key: KeychainService.KeychainKeys) async -> String? {
        do {
            return try await keychain.loadValueFromKeychain(for: key)
        } catch {
            Logger.shared.debug("Error when load value from keychain: \(error.localizedDescription)")
            return nil
        }
    }

    @MainActor
    private func saveValueToKeychain(_ value: String?, for key: KeychainService.KeychainKeys) async {
        guard let value = value else {
            do {
                try await keychain.deleteValueFromKeychain(for: key)
            } catch {
                Logger.shared.debug("Error when delete value from keychain: \(error.localizedDescription)")
            }
            return
        }
        
        do {
            try await keychain.saveValueToKeychain(value, for: key)
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
