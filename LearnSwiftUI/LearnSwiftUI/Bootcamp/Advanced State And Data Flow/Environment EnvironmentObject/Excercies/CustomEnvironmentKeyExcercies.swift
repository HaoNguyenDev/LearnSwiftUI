//
//  CustomEnvironmentKeyExcercies.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/2/26.
//

import SwiftUI

protocol CustomAppFont {
    var titleFont: Font { get }
    var subtitleFont: Font { get }
}

protocol CustomAppTextColor {
    var primaryTextColor: Color { get }
    var secondaryTextColor: Color { get }
}

protocol CustomAppBackground {
    var primaryBackground: Color { get }
    var secondaryBackground: Color { get }
}

enum CustomAppThemeExcercies {
    case light, dark
}

extension CustomAppThemeExcercies: CustomAppFont {
    var titleFont: Font {
        .system(size: 30, weight: .bold, design: .rounded)
    }
    
    var subtitleFont: Font {
        .system(size: 18, weight: .semibold, design: .rounded)
    }
}

extension CustomAppThemeExcercies: CustomAppTextColor {
    var primaryTextColor: Color {
        return self == .light ? .black : .white
    }
    
    var secondaryTextColor: Color {
        return .secondary
    }
}

extension CustomAppThemeExcercies: CustomAppBackground {
    var primaryBackground: Color {
        return self == .light ? .white : .black
    }
    
    var secondaryBackground: Color {
        return self == .light ? .secondary : .white
    }
}

struct CustomAppThemeKey: EnvironmentKey {
    static var defaultValue: CustomAppThemeExcercies = .light
}

extension EnvironmentValues {
    var customAppThemeKey: CustomAppThemeExcercies {
        get { self[CustomAppThemeKey.self] }
        set { self[CustomAppThemeKey.self] = newValue }
    }
}

extension View {
    func setCustomAppThemeExcercies(_ theme: CustomAppThemeExcercies) -> some View {
        environment(\.customAppThemeKey, theme)
    }
}

struct ParentViewAppThemeExcercies: View {
    @State private var switchTheme = false
    
    var body: some View {
        VStack{
            SubviewAppThemeExcercies()
                .setCustomAppThemeExcercies(switchTheme ? .light : .dark)
            Button("Switch Theme") {
                switchTheme.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct SubviewAppThemeExcercies: View {
    @Environment(\.customAppThemeKey) var appTheme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello SwiftUI!")
                .font(appTheme.titleFont)
                .foregroundStyle(appTheme.primaryTextColor)
                .background(appTheme.primaryBackground)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Let's discovery SwiftUI with me....")
                .font(appTheme.subtitleFont)
                .foregroundStyle(appTheme.secondaryTextColor)
                .background(appTheme.secondaryBackground)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

#Preview {
    ParentViewAppThemeExcercies()
}
