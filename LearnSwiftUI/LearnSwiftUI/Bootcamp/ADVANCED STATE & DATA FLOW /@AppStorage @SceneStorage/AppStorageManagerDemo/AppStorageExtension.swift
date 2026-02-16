//
//  AppStorageExtension.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 16/2/26.
//

import SwiftUI

extension AppStorage where Value == Bool {
    init<K: AppStorageKey>(_ keyType: K.Type) where K.Value == Bool {
        self.init(wrappedValue: keyType.defaultValue, keyType.key)
    }
}

extension AppStorage where Value == String {
    init<K: AppStorageKey>(_ keyType: K.Type) where K.Value == String {
        self.init(wrappedValue: keyType.defaultValue, keyType.key)
    }
}

extension AppStorage where Value == Int {
    init<K: AppStorageKey>(_ keyType: K.Type) where K.Value == Int {
        self.init(wrappedValue: keyType.defaultValue, keyType.key)
    }
}

extension AppStorage where Value == Double {
    init<K: AppStorageKey>(_ keyType: K.Type) where K.Value == Double {
        self.init(wrappedValue: keyType.defaultValue, keyType.key)
    }
}

extension View {
    func resetStorageForPreview() -> some View {
        onAppear {
            UserDefaults.standard.removeObject(forKey: Storage.Onboarding.isOnboarded.key)
            UserDefaults.standard.removeObject(forKey: Storage.Appearance.theme.key)
        }
    }
}
