//
//  Login.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//

import SwiftUI

extension Router {
    enum Login: Routable {
        case forgotPassword
        case register
        
        var id: String {
            switch self {
            case .forgotPassword:
                return "forgotPassword"
            case .register:
                return "register"
            }
        }
    }
}

struct LoginCoordinator: View, ScreenCoordinator {
    @Environment(UserSettings.self) var userSettings
    typealias ScreenRouter = Router.Login
    var navRouter: any NavRouterProtocol
    @State private var loginModel = LoginModel()
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
    }
    
    @ViewBuilder
    func getView() -> some View {
        LoginView(loginModel: loginModel, loginSuccess: {
            Logger.shared.debug("Login success")
            userSettings.token = "token 123"
            navRouter.push(Router.homeRouter, animate: true)
        }, forgotPassword: {
            navRouter.push(ScreenRouter.forgotPassword, animate: true)
        }, register: {
            navRouter.push(ScreenRouter.register, animate: true)
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .forgotPassword:
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.bold)
        case .register:
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

struct LoginView: View {
    @Environment(UserSettings.self) private var userSettings
    @State var loginModel: LoginModel
    @State private var showLoading: Bool = false

    var loginSuccess: VoidResult?
    var gotoForgotPassword: VoidResult?
    var gotoRegister: VoidResult?
    
    init(loginModel: LoginModel,
         loginSuccess: VoidResult?,
         forgotPassword: VoidResult?,
         register: VoidResult?) {
        self.loginModel = loginModel
        self.loginSuccess = loginSuccess
        self.gotoForgotPassword = forgotPassword
        self.gotoRegister = register
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

extension LoginView {
    @ViewBuilder
    private var content: some View {
        VStack {
            Text("Login View")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 100)
            
            Button {
               loginSuccess?()
            } label: {
                Text("Login")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                gotoRegister?()
            } label: {
                Text("Register")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                gotoForgotPassword?()
            } label: {
                Text("Forgot password")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
        }
    }

}

@Observable final class LoginModel {}

#Preview {
    LoginView(loginModel: LoginModel(),
              loginSuccess: nil,
              forgotPassword: nil,
              register: nil)
    .environment(UserSettings.shared)
}
