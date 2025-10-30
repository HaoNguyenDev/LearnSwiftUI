//
//  KeychainService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 17/10/25.
//

import KeychainAccess
import Foundation

actor KeychainService {
    
    static let shared = KeychainService()
    private let keychain: Keychain
    
    private init() {
        keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "haonguyen.LearnSwiftUI")
    }
    
    func loadValueFromKeychain(for key: KeychainKeys) throws -> String? {
        return try keychain.get(key.rawValue)
    }
    
    func saveValueToKeychain(_ value: String, for key: KeychainKeys) throws {
        try keychain.set(value, key: key.rawValue)
    }
    
    func deleteValueFromKeychain(for key: KeychainKeys) throws {
        try keychain.remove(key.rawValue)
    }
    
    func clearAllKeychainValues() throws {
        try keychain.allKeys().forEach { try keychain.remove($0) }
    }
}


extension KeychainService {
    func getAccessToken() -> String? {
        keychain[KeychainKeys.token.rawValue]
    }
}

extension KeychainService {
    enum KeychainKeys: String, CaseIterable {
        case username = "haonguyen.LearnSwiftUI.key.username"
        case password = "haonguyen.LearnSwiftUI.key.password"
        case token = "haonguyen.LearnSwiftUI.key.token"
        case refreshToken = "haonguyen.LearnSwiftUI.key.refreshToken"
    }
}
