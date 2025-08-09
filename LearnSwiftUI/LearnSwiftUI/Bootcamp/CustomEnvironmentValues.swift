//
//  CustomEnvironmentValues.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/8/25.
//

import Foundation
import SwiftUI

struct HSpacing {
    let paddingText: CGFloat = 5
    
}

struct HColor {
    let textColor = Color("CustomTextColor")
    let backgroundColor = Color("CustomBackgroundColor")
}

struct HCustomDesign {
    let color = HColor()
    let spacing = HSpacing()
}

//Step 1: Define the environment key
struct CustomDesignKey: EnvironmentKey {
    static let defaultValue = HCustomDesign()
}

//Step 2: Extend EnvironmentValues
extension EnvironmentValues {
    var hCustomDesign: HCustomDesign {
        get { self[CustomDesignKey.self] }
        set { self[CustomDesignKey.self] = newValue }
    }
}

//-------------//---------------//
struct CustomColor {
    let textColor = Color("CustomTextColor")
    let backgroundColor = Color("CustomBackgroundColor")
}

//Step 1: Define the environment key
struct CustomColorKey: EnvironmentKey {
    static let defaultValue = CustomColor()
}

//Step 2: Extend EnvironmentValues
extension EnvironmentValues {
    var colorEnv: CustomColor {
        get { self[CustomColorKey.self] }
        set { self[CustomColorKey.self] = newValue }
    }
}

//Step 1: Define the environment key
struct APIEndPoint: EnvironmentKey {
    static let defaultValue: String = "https://api.example.com" /// The default value for the environment key.
}

struct DebugModeKey: EnvironmentKey {
    static let defaultValue: Bool = false /// The default value for the environment key.
}


//Step 2: Extend EnvironmentValues
extension EnvironmentValues {
    var apiPoint: String {
        get { self[APIEndPoint.self] }
        set { self[APIEndPoint.self] = newValue }
    }
    
    var isDebugMode: Bool {
        get { self[DebugModeKey.self] }
        set { self[DebugModeKey.self] = newValue }
    }
}

//Step 3: Use them
struct EnvironmentKeyContentView: View {
    var body: some View {
        UseEnvironmentView() // Inject environment to view
            .environment(\.apiPoint, "https://api.example.com/debug")
            .environment(\.isDebugMode, true)
            .environment(\.colorEnv, CustomColor())
            .environment(\.hCustomDesign, HCustomDesign())
    }
}

struct UseEnvironmentView: View {
    @Environment(\.apiPoint)    private var apiPoint
    @Environment(\.isDebugMode) private var isDebugMode
    @Environment(\.colorEnv) private var customColor
    @Environment(\.hCustomDesign) private var hCustomDesign
    
    var body: some View {
        Text("apiPoint: \(apiPoint)")
        Text("isDebugMode: \(isDebugMode)")
            .foregroundStyle(customColor.textColor)
        Circle()
            .fill(customColor.backgroundColor)
        
        Button {
            
        } label: {
            Text("Button")
                .font(.headline)
                .foregroundStyle(hCustomDesign.color.textColor)
                .padding(hCustomDesign.spacing.paddingText)
                
        }
        .buttonStyle(.bordered)

    }
}

#Preview {
    EnvironmentKeyContentView()
}
