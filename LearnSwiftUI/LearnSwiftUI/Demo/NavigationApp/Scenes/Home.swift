//
//  Home.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/8/25.
//

import Foundation
import SwiftUI

extension Router {
    enum Home: Routable {
        case feature1
        case feature2
        
        var id: String {
            switch self {
            case .feature1:
                return "feature1"
            case .feature2:
                return "feature2"
            }
        }
    }
}

struct HomeCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.Home
    var navRouter: any NavRouterProtocol
    @StateObject private var loginModel = HomeViewModel()
    
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
        HomeView(model: loginModel, gotoFeature1: {
            navRouter.push(Router.MainTab.feature1, animate: true)
        }, gotoFeature2: {
            navRouter.push(Router.MainTab.feature2, animate: true)
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        EmptyView()
    }
}

struct HomeView: View {
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var model: HomeViewModel
    @State private var showLoading: Bool = false

    var gotoFeature1: VoidResult?
    var gotoFeature2: VoidResult?
    
    init(model: HomeViewModel,
         gotoFeature1: VoidResult?,
         gotoFeature2: VoidResult?) {
        self.model = model
        self.gotoFeature1 = gotoFeature1
        self.gotoFeature2 = gotoFeature2
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

extension HomeView {
    @ViewBuilder
    private var content: some View {
        VStack {
            Text("Home View")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 100)
            
            Button {
                gotoFeature1?()
            } label: {
                Text("Future 1")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                gotoFeature2?()
            } label: {
                Text("Future 2")
                    .font(.headline)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.borderedProminent)
            
        }
    }

}

class HomeViewModel: ObservableObject {}

#Preview {
    HomeView(model: HomeViewModel(), gotoFeature1: nil, gotoFeature2: nil)
    .environmentObject(UserSettings.shared)
}

