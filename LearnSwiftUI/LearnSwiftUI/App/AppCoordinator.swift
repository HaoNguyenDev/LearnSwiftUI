//
//  AppCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

extension Route {
    enum AppCoordinator: Routable {
        case login
        case home
        var id: String {
            switch self {
            case .login: return "AppCoordinator.login"
            case .home: return "AppCoordinator.home"
            }
        }
    }
}

struct AppCoordinator: View {
    @State private var rootRouter = NavRoute()
    var body: some View {
        contentView
    }
    
    @ViewBuilder
    var contentView: some View {
        NavigationStack(path: $rootRouter.path) {
            BootcampListCoordinator(navRouter: rootRouter)
        }
        .ignoresSafeArea()
        
        .sheet(item: $rootRouter.sheet) { sheet in
            showSheet(routable: sheet.presentableView)
        }
        
        .fullScreenCover(item: $rootRouter.fullScreenCover) { fullScreenCover in
            showFullScreen(routable: fullScreenCover.presentableView)
        }
    }
}

extension AppCoordinator {
    @ViewBuilder
    func showSheet(routable: any Routable) -> some View {
        switch routable {
//        case Router.AppCoordinator.login:
//            LoginCoordinator(mainTabNavRouter: rootRouter, userSettings: userSettings)
//        case Router.PlaceholderView.view(let titleParam):
//            PlaceholderViewCoordinator(navRouter: rootRouter, title: titleParam)
        default: Text("OOPS!\nThis route is not implemented AppCoordinator showSheet function yet.")
        }
    }
    
    @ViewBuilder
    func showFullScreen(routable: any Routable) -> some View {
        switch routable {
//        case Router.AppCoordinator.login:
//            LoginCoordinator(mainTabNavRouter: rootRouter, userSettings: userSettings)
//        case Router.PlaceholderView.view(let titleParam):
//            PlaceholderViewCoordinator(navRouter: rootRouter, title: titleParam)
        default: Text("OOPS!\nThis route is not implemented at AppCoordinator showFullScreen function yet.")
        }
    }
}
