//
//  AppStorageKeys.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 16/2/26.
//

public protocol AppStorageKey {
    associatedtype Value
    static var key: String { get }
    static var defaultValue: Value { get }
}

// MARK: - Onboarding Domain

enum IsOnboardedKey: AppStorageKey {
    static let key = "app.isOnboarded"
    static let defaultValue = false
}

enum OnboardingStepKey: AppStorageKey {
    static let key = "app.onboardingStep"
    static let defaultValue = 0
}

// MARK: - Appearance Domain

enum AppThemeKey: AppStorageKey {
    static let key = "app.theme"
    static let defaultValue = "system"
}

enum FontSizeKey: AppStorageKey {
    static let key = "app.fontSize"
    static let defaultValue = 16
}

// MARK: - User Domain

enum UsernameKey: AppStorageKey {
    static let key = "app.username"
    static let defaultValue = ""
}
