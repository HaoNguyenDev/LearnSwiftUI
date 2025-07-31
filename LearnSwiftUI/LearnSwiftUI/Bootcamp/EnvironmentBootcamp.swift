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
        self.listItems = [AppleProduct(name: "(1) iPhone 13", price: 1000.0),
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

class EnvironmentBootcampStore2: ObservableObject {
    @Published var listItems: [AppleProduct]
    
    init() {
        self.listItems = [AppleProduct(name: "(2) iPhone 13", price: 1000.0),
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
    @StateObject private var store2 = EnvironmentBootcampStore2() // Object conform i@ObservableObject protocol
    
    var body: some View {
        EnvironmentSubView()
            .environment(store)
            .environmentObject(store2)
    }
}

struct EnvironmentSubView: View {
    @Environment(EnvironmentBootcampStore.self) var store
    @EnvironmentObject var store2: EnvironmentBootcampStore2
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(store2.listItems) { item in
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
    @EnvironmentObject var appTheme: AppTheme // Khai báo để SwiftUI biết injec

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
        }
        .padding()
    }
}

#Preview(body: {
    EnvironmentInfoView()
        .environmentObject(AppTheme())
})

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
