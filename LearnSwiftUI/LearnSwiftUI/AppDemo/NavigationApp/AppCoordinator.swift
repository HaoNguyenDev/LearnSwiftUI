//
//  AppCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//


import SwiftUI

struct AppCoordinator: View {
    @Environment(AppSettings.self) private var appSettings
    @Environment(UserSettings.self) private var userSettings
    @State var rootRouter = NavRouter()
    @State private var isShowBlockingView: Bool = false
    
    var body: some View {
        Group {
            if isShowBlockingView {
                blockingView
            } else {
                contentView
            }
        }
        .task { startCheckingApp() }
    }
    
    private func startCheckingApp() {
        let isMatchBundleId = Bundle.main.bundleIdentifier == "haonguyen.LearnSwiftUI"
        
        if !isMatchBundleId {
            isShowBlockingView = true
            return
        }
        
        isShowBlockingView = false
    }
    
    @ViewBuilder
    var blockingView: some View {
        Text("Device restricted")
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    var contentView: some View {
        ZStack {
            if appSettings.isMaintenance {
                maintenanceView
            } else {
                NavigationStack(path: $rootRouter.path) {
                    SplashCoordinator(navRouter: rootRouter)
                }
                .sheet(item: $rootRouter.sheet) { sheet in
                    showSheet(routable: sheet.routable)
                }
                .fullScreenCover(item: $rootRouter.fullScreenCover) { cover in
                    showFullScreen(routable: cover.routable)
                }

            }
            /*
             if settings.isShowLoading {
             // Loading View
             loadingView
             }
             toastView(appState.userMessageState.toastMessages.first)
             informView(appState.userMessageState.informMessage)
             alertView(appState.userMessageState.alert)
             */
        }
        .onAppear {
            // TODO: Load remote config from backend
        }
    }
    
    @ViewBuilder
    var maintenanceView: some View {
        VStack {
            VStack {
                VStack(spacing: 32) {
                    VStack(spacing: 12) {
                        Text("System Maintenance")
                            .fontWeight(.semibold)
                        Text("Maintenance Message")
                            .fontWeight(.regular)
                    }
                    .multilineTextAlignment(.center)
                }
            }
            .padding(EdgeInsets(top: 130, leading: 40, bottom: 112, trailing: 40))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension AppCoordinator {
    @ViewBuilder
    func showSheet(routable: any Routable) -> some View {
        switch routable {
        case Router.Splash.login:
            LoginCoordinator(navRouter: rootRouter)
        case Router.Splash.home:
            HomeCoordinator(navRouter: rootRouter)
        case Router.PlaceholderView.view:
            PlaceholderViewCoordinator(navRouter: rootRouter)
        default: Text("OOPS!\nThis route is not implemented AppCoordinator showSheet function yet.")
        }
    }
    
    @ViewBuilder
    func showFullScreen(routable: any Routable) -> some View {
        switch routable {
        case Router.Splash.login:
            LoginCoordinator(navRouter: rootRouter)
        case Router.Splash.home:
            HomeCoordinator(navRouter: rootRouter)
        case Router.PlaceholderView.view:
            PlaceholderViewCoordinator(navRouter: rootRouter)
        default: Text("OOPS!\nThis route is not implemented at AppCoordinator showFullScreen function yet.")
        }
    }
}
//extension AppCoordinator {
//    @ViewBuilder
//    private var loadingView: UserInformView {
//        let loadingMessage = UserMessageItem(animationName: "ic_boost_loading",
//                                             title: "loading".localized(),
//                                             message: "loading_message".localized())
//        UserInformView(message: loadingMessage)
//    }
//
//    @ViewBuilder
//    private func toastView(_ message: UserMessageItem?) -> some View {
//        Group {
//            if let message = message {
//                UserMessageView(message: message) { msg in
//                    appState.userMessageState.hide()
//                    if msg.code == .sectionExpired {
//                        rootRouter.pop(to:Router.Splash.login)
//                    }
//                }
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func informView(_ message: UserMessageItem?) -> some View {
//        Group {
//            if let message {
//                UserInformView(message: message)
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func alertView(_ message: UserMessageItem?) -> some View {
//        Group {
//            if let message  {
//                let action = InformAction(title: message.actionTitle ?? "close".localized(),
//                                          callback: {
//                    appState.userMessageState.hideAlert()
//                    if message.code == .sectionExpired {
//                        rootRouter.popToRoot()
//                        rootRouter.push(Router.Splash.login, animate: false)
//                    }
//                })
//
//                UserInformView(message: message,
//                               primaryAction: action)
//            }
//        }
//    }
//}

#Preview {
    AppCoordinator()
        .environment(AppSettings.shared)
        .environment(UserSettings.shared)
}

