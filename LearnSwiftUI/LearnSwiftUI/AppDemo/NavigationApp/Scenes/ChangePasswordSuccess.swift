//
//  ChangePasswordSuccess.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/8/25.
//

import Foundation
import SwiftUI

extension Router {
    enum ChangePasswordSuccess: Routable {
        case empty
        var id: String { "empty" }
    }
}

struct ChangePasswordSuccessCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.ChangePasswordSuccess
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        successView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
    }
    
    @ViewBuilder
    private func successView() -> some View {
        ChangePasswordSuccessView(backToLogin: {
            navRouter.pop(to: Router.Splash.login, animate: true)
        }, backToChangePassword: {
            navRouter.pop(to: Router.MainTab.security, animate: true)
        })
        //        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            navRouter.pop(animate: true)
        }) {
            BackButton()
        })
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .empty:
            EmptyView()
        }
    }
}

struct ChangePasswordSuccessView: View {
    @State private var showLoading: Bool = false
    
    var backToLogin: VoidResult?
    var backToChangePassword: VoidResult?
    
    init(backToLogin: VoidResult?, backToChangePassword: VoidResult?) {
        self.backToLogin = backToLogin
        self.backToChangePassword = backToChangePassword
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

extension ChangePasswordSuccessView {
    @ViewBuilder
    private var content: some View {
        VStack {
            Text("Change Password Success View")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 100)
            
            Button {
                backToLogin?()
            } label: {
                Text("Back to Login")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                backToChangePassword?()
            } label: {
                Text("Back to ChangePassword")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
        }
    }
    
}

#Preview {
    ChangePasswordSuccessView(backToLogin: nil, backToChangePassword: nil)
}
