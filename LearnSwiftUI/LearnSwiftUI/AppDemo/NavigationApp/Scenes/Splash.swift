//
//  Splash.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//


import Foundation
import SwiftUI

extension Router {
    enum Splash: Routable {
        case login
        case home
        
        var id: String {
            switch self {
            case .home: return "home"
            case .login: return "login"
            }
        }
    }
}

struct SplashCoordinator: View, ScreenCoordinator {
    @Environment(UserSettings.self) var userSettings
    typealias ScreenRouter = Router.Splash
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRouter.self) { route in
                viewForRouter(router: route)
            }
    }
    
    @ViewBuilder
    func getView() -> some View {
        SplashView(onSkipUpdate: {
            if userSettings.hasLoggedIn {
                navRouter.push(ScreenRouter.login, animate: false)
                navRouter.push(ScreenRouter.home, animate: true)
            } else {
                navRouter.push(ScreenRouter.login, animate: true)
            }
        })
        .onAppear {
            //TESTING Show sheet
//            navRouter.showSheet(RouterView.init(routable: ScreenRouter.home))
//            navRouter.showFullScreenCover(RouterView.init(routable: ScreenRouter.login))
//            navRouter.showSheet(RouterView.init(routable: Router.Security.changePassword))
        }
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .login:
            LoginCoordinator(navRouter: navRouter)
        case .home:
            MainTabControllerView(navRouter: navRouter)
        }
    }
}

struct SplashView: View {
    var onSkipUpdate: VoidResult?
    @State var showLoading: Bool = false
    var body: some View {
        contentView
    }
}

extension SplashView {
    @ViewBuilder
    var contentView: some View {
        updateView
    }
    
    @ViewBuilder
    var updateView: some View {
        VStack {
            VStack {
                VStack(spacing: 32) {
                   
                    VStack(spacing: 12) {
                        Text("Splash Screen")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    .multilineTextAlignment(.center)
                }
                Spacer()
                VStack(spacing: 16) {
                    Button(action: {
                        onSkipUpdate?()
                    }, label: {
                        Text("Skip")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(EdgeInsets(top: 130, leading: 40, bottom: 112, trailing: 40))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SplashView()
        .environment(UserSettings.shared)
}
