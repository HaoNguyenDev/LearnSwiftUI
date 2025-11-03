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
    @State private var themeManager = ThemeManager.shared
    @State private var userSettings = UserSettings.shared
    @State private var appSettings = AppSettings.shared
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
            
//            AppCoordinator()
//                .environment(appSettings)
//                .environment(userSettings)
            
//            EnvironmentSettingView().environment(EnvironmentSettings())
            
//            AsyncAwaitBootcampView()
//            FocusStateBootcamp()
//            ListBootcamp()
//            TextFieldBootcamp()
//            PickerBootcamp()
//            ThemedTextView()
//                .environment(\.theme, themeVM.currentTheme)
//                .environment(themeVM)
            
//            NavigationStack {
//                WeatherMainView(vm: WeatherListViewModel(weatherService: WeatherServiceWrapper()))
//                    .navigationTitle("Weather")
//            }
            
//            DownloadView()
          
//            let countryCode = getCurrentCountryCode()
//            let paymentService = PaymentFactory.createPaymentService(for: countryCode)
//            NavigationStack {
//                PaymentView(vm: PaymentVM(paymentService: paymentService))
//                    .navigationBarTitle("Payment View")
//            }
            
            /// Combine
//            CbDemoContentView()
//            UserListContentView()
            CombineDefinitionContentView()

//            ContentView()
//                .environmentTheme(manager: themeManager)
//                .environment(userSettings)
            
            /// Timer
//            TimerPublisherBootcamp(totalDuration: 90)
            
            /// Actor
//            BankAccountView()
            
            /// Architecture
            /// MVVM
//            MVVMDemoUIKitContentView()
//            GithubUserListView(viewModel: GithubUserListVM()) { userDetail in
//
//            }
            
//            ViewToTestClass()
//            AlamofireTestView()
        }
    }
}
