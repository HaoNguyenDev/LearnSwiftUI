//
//  DemoAppStorageSettingsView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 16/2/26.
//

import SwiftUI

struct DemoAppStorageSettingsView: View {
    @AppStorage(Storage.Appearance.theme)       var theme
    @AppStorage(Storage.Appearance.fontSize)    var fontSize
    @AppStorage(Storage.User.username)          var username
    
    var body: some View {
        Form {
            Picker("Theme", selection: $theme) {
                Text("System").tag("system")
                Text("Dark").tag("dark")
                Text("Light").tag("light")
            }
            Stepper("Font size: \(fontSize)", value: $fontSize, in: 12...24)
        }
    }
}

#Preview {
    DemoAppStorageSettingsView()
}
