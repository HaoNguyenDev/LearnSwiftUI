//
//  MainTab.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//

import SwiftUI

enum TabType: Int, CaseIterable {
    case home = 0
    case account = 1
    case empty = 2
    
    static let allTabs: [TabType] = [.home, .account, .empty]

    var title: String {
        switch self {
        case .home: return "Home"
        case .account: return "Account"
        case .empty: return "Empty"
        }
    }
    
    var icon: Image {
        switch self {
        case .home: return Image(systemName: "house")
        case .empty: return Image(systemName: "pedal.accelerator")
        case .account: return Image(systemName: "person.crop.circle")
        }
    }
    
    var iconSelected: Image {
        switch self {
        case .home: return Image(systemName: "house.fill")
        case .empty: return Image(systemName: "pedal.accelerator.fill")
        case .account: return Image(systemName: "person.crop.circle.fill")
        }
    }
}

extension Router {
    enum MainTab: Routable {
        case security
        case feature1
        case feature2
        
        var id: String {
            switch self {
            case .security: return "security"
            case .feature1: return "feature1"
            case .feature2: return "feature2"
            }
        }
    }
}

struct MainTabControllerView: View {
    var navRouter: any NavRouterProtocol
    @Environment(UserSettings.self) private var settings
    @State var selectedTab = TabType.home.rawValue
    
    init(navRouter: any NavRouterProtocol) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .clear
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear
        ]
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.clear)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(Color.clear)
        ]
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear
        ]
        navBarAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear
        ]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        self.navRouter = navRouter
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeCoordinator(navRouter: navRouter).tag(0)
                AccountCoordinator(navRouter: navRouter).tag(1)
                PlaceholderViewCoordinator(navRouter: navRouter, title: nil).tag(2)
            }
            tabBar()
        }
        .navigationDestination(for: Router.MainTab.self) { route in
            viewForRoute(route: route)
        }
        //        .onReceive(NotificationCenter.default.publisher(for: .showSettingsScreen)) { _ in
        //            navRouter.push(Router.MainTab.settings, animate: true)
        //        }
        //        .onReceive(NotificationCenter.default.publisher(for: .showProfileScreen)) { _ in
        //            navRouter.push(Router.MainTab.profile, animate: true)
        //        }
        //        .onReceive(NotificationCenter.default.publisher(for: .showPromotionScreen)) { _ in
        //            selectedTab = 1
        //        }
        
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .bottomBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    @ViewBuilder
    private func tabBar() -> some View {
        HStack {
            ForEach(TabType.allTabs, id: \.self) { tab in
                tabItem(tab: tab, isSelected: selectedTab == tab.rawValue)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 24)
        .frame(width: 333, height: 72)
        .background(
            Color.gray
                .clipShape(RoundedRectangle(cornerRadius: 36))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
        )
    }
    
    @ViewBuilder
    private func tabItem(tab: TabType, isSelected: Bool) -> some View {
        Button {
            selectedTab = tab.rawValue
        } label: {
            HStack(spacing: 24) {
                VStack {
                    tabIcon(tab: tab, isSelected: isSelected)
                    if tab != .home {
                        Text(tab.title)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(isSelected ? .white : .black)
                    }
                }
                if tab == .home {
                    Rectangle()
                        .frame(width: 1, height: 40)
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    @ViewBuilder
    private func tabIcon(tab: TabType, isSelected: Bool) -> some View {
        if isSelected {
            tab.iconSelected
                .font(.body)
                .fontWeight(.semibold)
                .symbolRenderingMode(.monochrome)
            //                .symbolEffect(.wiggle, options: .repeat(.bitWidth))
                .foregroundStyle(.white)
            //            .resizable()
            //            .frame(width: 24, height: 24)
        } else {
            tab.icon
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            //            .resizable()
            //            .frame(width: 24, height: 24)
        }
    }
    
    @ViewBuilder
    func viewForRoute(route: Router.MainTab) -> some View {
        switch route {
        case .security:
            SecurityCoordinator(navRouter: navRouter)
        case .feature1:
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Feature 1")
        case .feature2:
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Feature 2")
        }
    }
}

#Preview {
    MainTabControllerView(navRouter: NavRouter())
        .environment(UserSettings.shared)
}
