//
//  KeychainStore.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/11/25.
//

import Foundation
import KeychainAccess

extension KeychainStore {
    enum KeychainKeys: String, CaseIterable {
        case username = "haonguyen.LearnSwiftUI.key.username"
        case password = "haonguyen.LearnSwiftUI.key.password"
        case accessToken = "haonguyen.LearnSwiftUI.key.accessToken"
        case refreshToken = "haonguyen.LearnSwiftUI.key.refreshToken"
    }
}

final class KeychainStore {
    static let shared = KeychainStore()
    let keychain: Keychain
    private init() {
        keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "haonguyen.LearnSwiftUI")
    }
    
    func set(_ value: String?, forKey key: KeychainStore.KeychainKeys) {
        if let value = value {
            keychain[key.rawValue] = value
        } else {
            keychain[key.rawValue] = nil
        }
    }
    
    func getString(forKey key: KeychainStore.KeychainKeys) -> String? {
        keychain[key.rawValue] as String?
    }
    
    func clearAllKeys() {
        keychain.allKeys().forEach { keychain[$0] = nil }
    }
    
    func clearToken() {
        keychain[KeychainKeys.accessToken.rawValue] = nil
    }
}
