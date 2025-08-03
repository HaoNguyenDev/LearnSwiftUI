//
//  Security.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/8/25.
//

import Foundation
import SwiftUI

extension Router {
    enum Security: Routable {
        case changePassword
        
        var id: String {
            switch self {
            case .changePassword:
                return "changePassword"
            }
        }
    }
}

struct SecurityCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.Security
    var navRouter: any NavRouterProtocol
    @StateObject private var loginModel = SecurityViewModel()
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        securityView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
    }
    
    @ViewBuilder
    private func securityView() -> some View {
        SecurityView(model: loginModel, changePassword: {
            navRouter.push(ScreenRouter.changePassword, animate: true)
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
        case .changePassword:
            ChangePasswordCoordinator(navRouter: navRouter)
        }
    }
}

struct SecurityView: View {
    @Environment(UserSettings.self) private var settings
    @ObservedObject var model: SecurityViewModel
    
    var changePassword: VoidResult?
    
    init(model: SecurityViewModel,
         changePassword: VoidResult?) {
        self.model = model
        self.changePassword = changePassword
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

extension SecurityView {
    @ViewBuilder
    private var content: some View {
        VStack {
            Text("Security View")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 100)
            
            Button {
                changePassword?()
            } label: {
                Text("Go to change password")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
        }
    }
    
}

class SecurityViewModel: ObservableObject {}

#Preview {
    SecurityView(model: SecurityViewModel(), changePassword: nil)
        .environment(UserSettings.shared)
}

