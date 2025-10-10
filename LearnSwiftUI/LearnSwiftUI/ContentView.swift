//
//  ContentView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

struct ContentView: View {
    // 1. Use @Environment to access the active theme.
    @Environment(\.theme) var theme: any ThemeProtocol
    
    // 2. Use @ObservedObject to listen for changes from ThemeManager (e.g., when you switch themes)
    @ObservedObject var themeManager = ThemeManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Use colors from the theme
            Text("Primary Title (Primary Text)")
                .font(theme.font.bold(ofSize: 24))
                .foregroundColor(theme.color.textPrimary)
            
            Text("Secondary Text (Secondary Text)")
                .font(theme.font.regular(ofSize: 16))
                .foregroundColor(theme.color.textSecondary)
            
            // Use brand color for Button
            Button(action: {
                // Theme switching logic
                print("Switching theme...")
                // themeManager.activeTheme = AnotherTheme()
            }) {
                Text("Switch theme")
                    .font(theme.font.medium(ofSize: 18))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(theme.color.buttonPrimaryBg)
                    .foregroundColor(theme.color.buttonCommonText) // Usually white color
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            HStack {
                Circle()
                    .fill(theme.color.semanticsSuccessFull)
                    .frame(width: 50, height: 50)
                Text("Success")
                    .foregroundColor(theme.color.semanticsSuccessFull)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // Use the main background color from the theme
        .background(theme.color.backgroundPrimary.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
}
