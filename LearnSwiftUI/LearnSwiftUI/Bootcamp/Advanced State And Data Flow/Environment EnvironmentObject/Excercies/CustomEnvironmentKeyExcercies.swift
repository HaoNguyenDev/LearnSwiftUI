//
//  CustomEnvironmentKeyExcercies.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/2/26.
//

import SwiftUI

protocol CustomThemeColorProtocol {
    // Background
    var bgColor: Color { get }
    var gradientBgColors: [Color] { get }
    
    // Text
    var textColor: Color { get }
    var secondaryTextColor: Color { get }
    var errorMessage: Color { get }
    
    // Button
    var buttonBgColor: Color { get }
    var buttonBgDisableColor: Color { get }
    var buttonBgSelectedColor: Color { get }
}

protocol CustomThemeFontProtocol {
    func bold(ofSize size: CGFloat) -> Font
    func regular(ofSize size: CGFloat) -> Font
    func semibold(ofSize size: CGFloat) -> Font
}

protocol CustomThemeAssetsProtocol {
    var currentThemeIconSf: String { get }
    var userAvatar: UIImage { get }
}

protocol CustomThemeProtocol {
    var color: CustomThemeColorProtocol { get }
    var font: CustomThemeFontProtocol { get }
    var assets: CustomThemeAssetsProtocol { get }
}

struct CustomLightThemeColors: CustomThemeColorProtocol {
    // Background
    var bgColor = Color(hex: "#ffffff")
    var gradientBgColors = [Color(hex: "#ffffff"), Color(hex: "#4C4CFF")]
    
    // Text
    var textColor = Color(hex: "#333333")
    var secondaryTextColor: Color = .secondary
    var errorMessage = Color(hex: "#cc0000")
    
    // Button
    var buttonBgColor = Color(hex: "#007AFF")
    var buttonBgDisableColor = Color(hex: "#007AFF").opacity(0.5)
    var buttonBgSelectedColor = Color(hex: "#006de5")
}

struct CustomLightThemeFonts: CustomThemeFontProtocol {
    func bold(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialBd.font(size: size)
    }
    
    func regular(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialRg.font(size: size)
    }
    
    func semibold(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialDmBd.font(size: size)
    }
}

struct CustomLightThemeAssets: CustomThemeAssetsProtocol {
    var currentThemeIconSf: String { "sun.max.fill" }
    var userAvatar: UIImage { UIImage() }
}

struct CustomDarkThemeColors: CustomThemeColorProtocol {
    // Background
    var bgColor = Color(hex: "#1C2526")
    var gradientBgColors = [Color(hex: "#4c4c4c"), Color(hex: "#000000")]
    
    // Text
    var textColor = Color(hex: "#ffffff")
    var secondaryTextColor: Color = .white.opacity(0.5)
    var errorMessage = Color(hex: "#cc0000")
    
    // Button
    var buttonBgColor = Color(hex: "#FFD700")
    var buttonBgDisableColor = Color(hex: "#FFD700").opacity(0.5)
    var buttonBgSelectedColor = Color(hex: "#FFD700")
}

struct CustomDarkThemeFonts: CustomThemeFontProtocol {
    func bold(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialBd.font(size: size)
    }
    
    func regular(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialRg.font(size: size)
    }
    
    func semibold(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialDmBd.font(size: size)
    }
}

struct CustomDarkThemeAssets: CustomThemeAssetsProtocol {
    var currentThemeIconSf: String { "moon.fill" }
    var userAvatar: UIImage { UIImage() }
}

struct CustomDarkTheme: CustomThemeProtocol {
    var color: any CustomThemeColorProtocol = CustomDarkThemeColors()
    var font: any CustomThemeFontProtocol = CustomDarkThemeFonts()
    var assets: any CustomThemeAssetsProtocol = CustomDarkThemeAssets()
}

struct CustomLightTheme: CustomThemeProtocol {
    var color: CustomThemeColorProtocol = CustomLightThemeColors()
    var font: CustomThemeFontProtocol = CustomLightThemeFonts()
    var assets: CustomThemeAssetsProtocol = CustomLightThemeAssets()
}


struct CustomAppThemeKey: EnvironmentKey {
    static var defaultValue: CustomThemeProtocol = CustomLightTheme()
}

extension EnvironmentValues {
    var customAppThemeKey: any CustomThemeProtocol {
        get { self[CustomAppThemeKey.self] }
        set { self[CustomAppThemeKey.self] = newValue }
    }
}

extension View {
    func setCustomAppThemeExcercies(_ theme: CustomThemeProtocol) -> some View {
        environment(\.customAppThemeKey, theme)
    }
}

struct ParentViewAppThemeExcercies: View {
    @State private var switchTheme = false
    
    var body: some View {
        SubviewAppThemeExcercies(switchTheme: $switchTheme)
            .setCustomAppThemeExcercies(switchTheme ? CustomLightTheme() : CustomDarkTheme())
    }
}

struct SubviewAppThemeExcercies: View {
    @Environment(\.customAppThemeKey) var theme
    @Binding var switchTheme: Bool
    
    var body: some View {
        VStack() {
            Text("Hello SwiftUI!")
                .font(theme.font.bold(ofSize: 30))
                .foregroundStyle(theme.color.textColor)
                .background(theme.color.bgColor)
                .frame(maxWidth: .infinity)
            
            Text("Let's discovery SwiftUI with me....")
                .font(theme.font.regular(ofSize: 18))
                .foregroundStyle(theme.color.secondaryTextColor)
                .background(theme.color.bgColor)
                .frame(maxWidth: .infinity)
                Spacer()
                .frame(height: 30)
            
            Button {
                switchTheme.toggle()
            } label: {
                Text("Switch Theme")
                    .font(theme.font.bold(ofSize: 30))
                    .foregroundStyle(theme.color.textColor)
                    .padding()
                    .background(theme.color.buttonBgColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
    }
}

#Preview {
    ParentViewAppThemeExcercies()
}
