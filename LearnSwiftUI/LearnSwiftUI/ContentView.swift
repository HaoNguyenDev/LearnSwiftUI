//
//  ContentView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(UserSettings.self) var userSettings
    
    var body: some View {
        VStack(spacing: 20) {
        
            Text("Primary Title (Primary Text)")
                .font(theme.font.bold(ofSize: 24))
                .foregroundColor(theme.color.textPrimary)
            
            Text("Secondary Text (Secondary Text)")
                .font(theme.font.regular(ofSize: 16))
                .foregroundColor(theme.color.textSecondary)
            
            Button(action: {
                print("UserSettings Switching theme...")
                userSettings.isDarkMode.toggle()
            }) {
                Text("UserSettings Switching theme...")
                    .font(theme.font.medium(ofSize: 18))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(theme.color.buttonPrimaryBg)
                    .foregroundColor(theme.color.buttonCommonText)
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
            
            
            ContentSubview()
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // Use the main background color from the theme
        .background(theme.color.backgroundPrimary.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
        .environmentTheme(manager: ThemeManager.shared)
        .environment(UserSettings.shared)
}


struct ContentSubview: View {
    @Environment(\.theme) var theme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: .infinity, maxHeight: 200)
            .foregroundStyle(theme.color.buttonPrimaryBg)
            .overlay {
                Text("Text Color")
                    .foregroundStyle(theme.color.buttonCommonText)
            }
    }
}
