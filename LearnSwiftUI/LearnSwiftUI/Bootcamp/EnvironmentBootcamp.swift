//
//  EnvironmentBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/7/25.
//

import Foundation
import SwiftUI

@Observable
class EnvironmentBootcampStore {
    var listItems: [AppleProduct] // No need define i@Published if conform i@Observable
    
    init() {
        self.listItems = [AppleProduct(name: "iPhone 13", price: 1000.0),
                          AppleProduct(name: "MacBook Pro", price: 2000.0),
                          AppleProduct(name: "AirPods Pro", price: 300.0),
                          AppleProduct(name: "Watch Series 7", price: 400.0),
                          AppleProduct(name: "iMac 24-inch", price: 1500.0),
                          AppleProduct(name: "iPad Pro 11-inch", price: 800.0),
                          AppleProduct(name: "Apple TV 4K", price: 300.0),
                          AppleProduct(name: "HomePod mini", price: 100.0),
                          AppleProduct(name: "Mac mini (M2)", price: 900.0),
                          AppleProduct(name: "iMac 27-inch", price: 1800.0),
                          AppleProduct(name: "MacBook Air (M2)", price: 900.0),
                          AppleProduct(name: "Apple Watch Series 6", price: 350.0),
                          AppleProduct(name: "iPad Air (5th generation)", price: 600.0),
                          AppleProduct(name: "Apple TV 3rd generation", price: 200.0),
                          AppleProduct(name: "iMac 24", price: 1500.0)]
    }
}

struct EnvironmentBootcamp: View {
    @State private var store = EnvironmentBootcampStore() // Object conform i@Observable
    
    var body: some View {
        EnvironmentSubView()
            .environment(store)
    }
}

struct EnvironmentSubView: View {
    @Environment(EnvironmentBootcampStore.self) var store

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(store.listItems) { item in
                    Text("\(item.name) - \(item.price)").padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    EnvironmentBootcamp()
}

//---------------------//---------------------//---------------------//

class AppTheme: ObservableObject {
    @Published var isDarkMode = false
    @Published var primaryColor = Color.blue
    @Published var secondaryColor = Color.green
}

struct EnvironmentInfoView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.locale) var locale
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.openURL) var openURL
    @EnvironmentObject var appTheme: AppTheme

    @State private var showSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Color Scheme")
                .font(.title)
            Text(colorScheme == .dark ? "Dark" : "Light")
                .foregroundColor(appTheme.primaryColor)

            Text("Locale/Language")
                .font(.title)
            if let languageCode = locale.language.languageCode?.identifier {
                Text(languageCode)
                    .foregroundColor(appTheme.secondaryColor)
            } else {
                Text("Unknown")
            }

            Text("Scene Phase")
                .font(.title)
            Text(scenePhase.hashValue.description)
                .foregroundColor(appTheme.primaryColor)

            Text("Size Classes")
                .font(.title)
            HStack {
                VStack {
                    Text("Horizontal: $horizontalSizeClass.rawValue)")
                        .foregroundColor(appTheme.secondaryColor)
                }
                VStack {
                    Text("Vertical: $verticalSizeClass.rawValue)")
                        .foregroundColor(appTheme.primaryColor)
                }
            }

            Text("App Theme")
                .font(.title)
            VStack {
                Circle()
                    .fill(appTheme.primaryColor)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 50, height: 50)
                
                Text("Theme color: \($appTheme.primaryColor.wrappedValue)")
                    .foregroundColor(appTheme.primaryColor)
            }
            
            Button("Show sheet") {
                showSheet = true
            }.buttonStyle(.borderedProminent)
            
            Button("Open URL") {
                openURL(URL(string: "https://www.apple.com")!)
            }.buttonStyle(.borderedProminent)
            
            Button("Open Setting") {
                openURL(URL(string: UIApplication.openSettingsURLString)!)
            }.buttonStyle(.borderedProminent)
            
            
        }
        .padding()
        .sheet(isPresented: $showSheet) {
            ModalView()
        }
    }
}

struct ModalView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Modal View")
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(20)
            
            Button("Dismiss") {
                dismiss()
            }.buttonStyle(.borderedProminent)
        }
    }
}

#Preview(body: {
    EnvironmentInfoView()
        .environmentObject(AppTheme())
})

//---------------------//---------------------//---------------------//

@Observable
class EnvironmentSettings {
//    @ObservationIgnored
    var isDarkModeForced: Bool = false
    var preferredFontSize: Double = 16.0
    var enableNotifications: Bool = true
    var accentColor: Color = .blue
    var userName: String = ""
    
    //Computed properties
    var effectiveColorScheme: ColorScheme? {
        isDarkModeForced ? .dark : nil
    }
}

struct EnvironmentSettingView: View {
    @Environment(EnvironmentSettings.self) private var settings
    
    var body: some View {
        @Bindable var bindableAppSetting = settings
        
        Form {
            Section("Appearance") {
                Toggle("Force Dark Mode", isOn: $bindableAppSetting.isDarkModeForced)
                ColorPicker("Accent Color", selection: $bindableAppSetting.accentColor)
                HStack {
                    Text("Text Size")
                    Slider(value: $bindableAppSetting.preferredFontSize, in: 12...50, step: 1)
                    Text("Size: \(Int(settings.preferredFontSize))")
                }
            }
            
            Section("Profile") {
                TextField("Username", text: $bindableAppSetting.userName)
                Toggle("Notifications", isOn: $bindableAppSetting.enableNotifications)
            }
            
            
            Section("Result") {
                Text("Color Mode")
                    .font(.system(size: settings.preferredFontSize))
                    .padding()
                    .foregroundStyle(settings.isDarkModeForced ? .white : .primary)
                    .background(settings.isDarkModeForced ? .black : settings.accentColor)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                Circle()
                    .fill(settings.accentColor)
                    .frame(width: 80, height: 80)
                    .overlay {
                        Image(systemName: "macpro.gen3.fill")
                            .foregroundColor(.white)
                            .font(.system(size: settings.preferredFontSize))
                    }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    EnvironmentSettingView()
        .environment(EnvironmentSettings())
}
//---------------------//---------------------//---------------------//


@Observable
class AppParams {
    var url: URL?
    var isDebug: Bool = false
    var appName: String = "MyApp"
    
    func reset() {
        url = nil
        isDebug = false
        appName = ""
    }
}

struct AppParamsKey: EnvironmentKey {
    static let defaultValue: AppParams? = nil
}

extension EnvironmentValues {
    var createAppParams: AppParams? {
        get { self[AppParams.self] }
        set { self[AppParams.self] = newValue }
    }
}

struct EnvironmentInfoView2: View {
    @Environment(\.createAppParams) var params
    
    var body: some View {
        Text(params?.appName ?? "No Params")
            .onAppear {
                params?.appName = "Hello World!"
            }
    }
}

#Preview {
    EnvironmentInfoView2()
}
