//
//  NavigationManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//

import SwiftUI

// Define the scenes in the app
enum Scenes: Hashable {
    case detailView(id: Int) // Detail view with an ID
    case settingView // Settings view
    case profileView // Profile view
    
    var title: String {
        switch self {
        case .detailView:
            return "Detail"
        case .settingView:
            return "Setting"
        case .profileView:
            return "Profile"
        }
    }
}

// Class to manage navigation, sheets, and full-screen covers
class NavigationManager: ObservableObject {
    // Navigation path for NavigationStack
    @Published var navPath = NavigationPath()
    
    // Sheet presentation state and scene
    @Published var isSheetPresented = false
    @Published var sheetScene: Scenes?
    
    // Full-screen cover presentation state and scene
    @Published var isFullScreenCoverPresented = false
    @Published var fullScreenCoverScene: Scenes?
    
    // Push a new scene to the navigation stack
    func push(_ scene: Scenes) {
        navPath.append(scene)
    }
    
    // Pop the last scene from the navigation stack
    func pop() {
        if !navPath.isEmpty {
            navPath.removeLast()
        }
    }
    
    // Pop a specified number of scenes from the navigation stack
    func pop(count: Int) {
        let removeCount = min(count, navPath.count)
        navPath.removeLast(removeCount)
    }
    
    // Pop all scenes to return to the root
    func popToRoot() {
        navPath = NavigationPath()
    }
    
    // Replace the entire navigation path with a single scene
    func replace(with scene: Scenes) {
        navPath = NavigationPath([scene])
    }
    
    // Show a sheet with the specified scene
    func showSheet(_ scene: Scenes) {
        sheetScene = scene
        isSheetPresented = true
    }
    
    // Dismiss the current sheet
    func dismissSheet() {
        isSheetPresented = false
        sheetScene = nil
    }
    
    // Show a full-screen cover with the specified scene
    func showFullScreenCover(_ scene: Scenes) {
        fullScreenCoverScene = scene
        isFullScreenCoverPresented = true
    }
    
    // Dismiss the current full-screen cover
    func dismissFullScreenCover() {
        isFullScreenCoverPresented = false
        fullScreenCoverScene = nil
    }
}

// Root view of the app
struct NavigationManagerBootcamp: View {
    @StateObject private var navManager = NavigationManager() // Initialize NavigationManager
    
    var body: some View {
        NavigationStack(path: $navManager.navPath) {
            VStack(spacing: 30) {
                Text("Home View")
                    .font(.largeTitle)
                
                Button("Go to Detail") {
                    navManager.push(.detailView(id: 1))
                }
                
                Button("Go to Setting") {
                    navManager.push(.settingView)
                }
                
                Button("Go to Profile") {
                    navManager.push(.profileView)
                }
                
                Button("Show Profile Sheet") {
                    navManager.showSheet(.profileView)
                }
                
                Button("Show Settings Full Screen") {
                    navManager.showFullScreenCover(.settingView)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            
            // Define navigation destinations
            .navigationDestination(for: Scenes.self) { scene in
                switch scene {
                case .detailView(let id):
                    DetailView(id: id)
                case .settingView:
                    SettingView()
                case .profileView:
                    ProfileView()
                }
            }
            // Present sheet based on NavigationManager state
            .sheet(isPresented: $navManager.isSheetPresented) {
                if let scene = navManager.sheetScene {
                    destinationView(for: scene)
                }
            }
            // Present full-screen cover based on NavigationManager state
            .fullScreenCover(isPresented: $navManager.isFullScreenCoverPresented) {
                if let scene = navManager.fullScreenCoverScene {
                    destinationView(for: scene)
                }
            }
        }
        .environmentObject(navManager) // Share NavigationManager with child views
    }
    
    // Helper function to map Scenes to views
    @ViewBuilder
    private func destinationView(for scene: Scenes) -> some View {
        switch scene {
        case .detailView(let id):
            DetailView(id: id)
        case .settingView:
            SettingView()
        case .profileView:
            ProfileView()
        }
    }
}

// Detail view
struct DetailView: View {
    @EnvironmentObject private var navManager: NavigationManager
    let id: Int
    
    var body: some View {
        ZStack {
            Color.green
            
            VStack(spacing: 30) {
                Text("Details of ID: \(id)")
                    .font(.title)
                
                Button("Go to Settings") {
                    navManager.push(.settingView) // Navigate to SettingView
                }
                
                Button("Go to Another Detail") {
                    navManager.push(.detailView(id: Int.random(in: 1...100))) // Navigate to new DetailView
                }
                
                Button("Show Profile Sheet") {
                    navManager.showSheet(.profileView) // Show ProfileView as sheet
                }
                
                Button("Show Settings Full Screen") {
                    navManager.showFullScreenCover(.settingView) // Show SettingView as full-screen cover
                }
                
                Button("Back") {
                    navManager.pop() // Go back
                }
                
                Button("Back to Home") {
                    navManager.popToRoot() // Return to root
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { navManager.pop() }) {
                    Image(systemName: "arrowshape.left.circle")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { navManager.popToRoot() }) {
                    Image(systemName: "house")
                }
            }
        }
    }
}

// Settings view
struct SettingView: View {
    @EnvironmentObject private var navManager: NavigationManager
    
    var body: some View {
        ZStack {
            Color.red
            VStack(spacing: 30) {
                Text("Setting View")
                    .font(.title)
                
                Button("Go to Profile") {
                    navManager.push(.profileView) // Navigate to ProfileView
                }
                
                Button("Dismiss") {
                    navManager.dismissSheet() // Dismiss sheet if presented
                    navManager.dismissFullScreenCover() // Dismiss full-screen cover if presented
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { navManager.popToRoot() }) {
                    Image(systemName: "house")
                }
            }
        }
    }
}

// Profile view
struct ProfileView: View {
    @EnvironmentObject private var navManager: NavigationManager
    
    var body: some View {
        ZStack {
            Color.yellow
            VStack(spacing: 30) {
                Text("Profile View")
                    .font(.title)
                
                Button("Back to Home") {
                    navManager.popToRoot() // Return to root
                }
                
                Button("Dismiss") {
                    navManager.dismissSheet() // Dismiss sheet if presented
                    navManager.dismissFullScreenCover() // Dismiss full-screen cover if presented
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { navManager.popToRoot() }) {
                    Image(systemName: "house")
                }
            }
        }
    }
}

#Preview {
    NavigationManagerBootcamp()
}
