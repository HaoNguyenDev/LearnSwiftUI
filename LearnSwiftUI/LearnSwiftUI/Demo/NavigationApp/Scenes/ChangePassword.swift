//
//  ChangePassword.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/8/25.
//

import Foundation
import SwiftUI

extension Router {
    enum ChangePassword: Routable {
        case changePasswordSuccess
        
        var id: String {
            switch self {
            case .changePasswordSuccess:
                return "ChangePasswordSuccess"
            }
        }
    }
}

struct ChangePasswordCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.ChangePassword
    var navRouter: any NavRouterProtocol
    @StateObject private var loginModel = ChangePasswordViewModel()
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        changePasswordView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
    }
    
    @ViewBuilder
    private func changePasswordView() -> some View {
        ChangePasswordView(model: loginModel, changePasswordResult: { result in
            if result {
                navRouter.pop(to: Router.Splash.home, animate: true)
                //                navRouter.pop(animate: true)
                //                navRouter.push(ScreenRouter.changePasswordSuccess, animate: true)
            }
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
        case .changePasswordSuccess:
            Text("Change Password Successfully")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

struct ChangePasswordView: View {
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var model: ChangePasswordViewModel
    @State private var showLoading: Bool = false
    
    var changePasswordResult: SingleResult<Bool>?
    
    init(model: ChangePasswordViewModel,
         changePasswordResult: SingleResult<Bool>?) {
        self.model = model
        self.changePasswordResult = changePasswordResult
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

extension ChangePasswordView {
    @ViewBuilder
    private var content: some View {
        VStack {
            Text("ChangePassword View")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 100)
            
            Button {
                changePasswordResult?(true)
            } label: {
                Text("Change Now")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
        }
    }
    
}

class ChangePasswordViewModel: ObservableObject {}

#Preview {
    ChangePasswordView(model: ChangePasswordViewModel(), changePasswordResult: nil)
        .environmentObject(UserSettings.shared)
}

