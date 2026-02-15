//
//  EnvironmentDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/2/26.
//

import SwiftUI

struct EnvironmentDemo: View {
    // Read environment values from system
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.locale) var locale
    
    var body: some View {
        VStack {
            Text("Color Scheme: \(colorScheme == .dark ? "Dark" : "Light")")
            Text("Size Class: \(sizeClass == .compact ? "Compact" : "Regular")")
            Text("Locale: \(locale.identifier)")
        }
    }
}
