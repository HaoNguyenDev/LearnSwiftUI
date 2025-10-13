//
//  Account.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/8/25.
//

import Foundation
import SwiftUI

extension Router {
    enum Account: Routable {
        case security
        
        var id: String {
            switch self {
            case .security:
                return "account.security"
            }
        }
    }
}

struct AccountCoordinator: View, ScreenCoordinator {
    @Environment(UserSettings.self) var userSettings
    typealias ScreenRouter = Router.Account
    var navRouter: any NavRouterProtocol
    @StateObject private var loginModel = AccountViewModel()
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        accountView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
    }
    
    @ViewBuilder
    private func accountView() -> some View {
        AccountView(model: loginModel, logout: {
            userSettings.clearUserDatas()
            navRouter.push(Router.Splash.login, animate: false)
        }, gotoSecurity: {
            navRouter.push(Router.MainTab.security, animate: true)
        })
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            navRouter.pop(animate: true)
        }) {
            BackButton()
        })
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        EmptyView()
    }
}

struct AccountView: View {
    @Environment(UserSettings.self) private var settings
    @ObservedObject var model: AccountViewModel
    @State private var showLoading: Bool = false
    
    var logout: VoidResult?
    var gotoSecurity: VoidResult?
    
    init(model: AccountViewModel,
         logout: VoidResult?,
         gotoSecurity: VoidResult?) {
        self.model = model
        self.logout = logout
        self.gotoSecurity = gotoSecurity
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

extension AccountView {
    @ViewBuilder
    private var content: some View {
        VStack {
            Text("Account View")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 100)
            
            Button {
                logout?()
            } label: {
                Text("Logout")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                gotoSecurity?()
            } label: {
                Text("Go to Security")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
        }
    }
    
}

class AccountViewModel: ObservableObject {}

#Preview {
    AccountView(model: AccountViewModel(), logout: nil, gotoSecurity: nil)
        .environment(UserSettings.shared)
}

