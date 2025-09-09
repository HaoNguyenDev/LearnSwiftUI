//
//  LearnSwiftUIApp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

@main
struct LearnSwiftUIApp: App {
    @State private var sharedModel = SharedModel()
    @StateObject private var todoStore = TodoStore()
    @State private var themeVM = ThemeViewModel()
    var body: some Scene {
        WindowGroup {
//            TextBootCamp()
//            ShapesBootCamp()
//            ColorsBootcamp()
//            InitializerBootcamp(newPoint: 100)
//            GridBootcamp()
//            ButtonBootcamp()
//            SubviewBootcamp()
//            BindingBootcamp()
//            SheetBootcamp()
//            SateBootcamp()
//            StateObjectBootcamp()
            
//            TodoAppView()
//                .environment(sharedModel)
//                .environmentObject(todoStore)
            
//            EnvironmentBootcamp()
//                .environment(\.colorScheme, .dark)
//                .environment(sharedModel)
//            NavigationStackBootcamp()
//            NavigationStackCustomItemView()
//            NavigationManagerBootcamp()
//            AppCoordinator().environment(UserSettings.shared)
//            EnvironmentSettingView().environment(EnvironmentSettings())
//            GithubUserListView()
//            AsyncAwaitBootcampView()
//            FocusStateBootcamp()
//            ListBootcamp()
//            TextFieldBootcamp()
//            PickerBootcamp()
//            ThemedTextView()
//                .environment(\.theme, themeVM.currentTheme)
//                .environment(themeVM)
            
//            NavigationStack {
//              WeatherListView()
//                .navigationTitle("Weather")
//                .environment(WeatherServiceWrapper())
//            }
            
//            NavigationStack {
//                WeatherMainView(vm: WeatherListViewModel(weatherService: WeatherServiceWrapper()))
//                    .navigationTitle("Weather")
//            }
            
            DownloadView()

        }
    }
}
