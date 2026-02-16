//
//  AppStorageCentralizeKeys.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 16/2/26.
//

import Foundation
// This is the only file that needs to be read to know the entire app's storage

enum Storage {

    enum Onboarding {
        static let isOnboarded = IsOnboardedKey.self
        static let step = OnboardingStepKey.self
    }

    enum Appearance {
        static let theme = AppThemeKey.self
        static let fontSize = FontSizeKey.self
    }

    enum User {
        static let username = UsernameKey.self
    }
}
