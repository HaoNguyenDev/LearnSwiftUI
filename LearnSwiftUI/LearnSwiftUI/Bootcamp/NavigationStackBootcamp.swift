//
//  NavigationStackBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/7/25.
//

import Foundation
import SwiftUI

/*
 NavigationStack {
 // Content of view
 
 // Navigation destinations (screen will be displayed when pressing button or gesture)
 .navigationDestination(for: MyModel.self) { model in
 // View displayed when navigating to a MyModel object
 }
 }
 */

enum Scenes {
    case detailView
    case settingView
    
    var title: String {
        switch self {
        case .detailView:
            return "Detail"
        case .settingView:
            return "Setting"
        }
    }
}

struct NavigationStackBootcamp: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) { // NavigationStack look the changes of $navigationPath
            VStack(spacing: 30) {
                Text("Home View")
                    .font(.largeTitle)
                
                Button("Go to Detail") {
                    navigationPath.append(Scenes.detailView) // Thêm giá trị vào path
                }
                
                Button("Go to Setting") {
                    navigationPath.append(Scenes.settingView) // Thêm giá trị khác
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            
            // Destination manages changes from navigationPath
            .navigationDestination(for: Scenes.self) { value in
                if value == Scenes.detailView {
                    DetailView(id: 1)
                } else if value == Scenes.settingView {
                    SettingView()
                }
            }
            
        }
    }
}

struct DetailView: View {
    let id: Int
    
    var body: some View {
        VStack {
            Text("Details of ID: \(id)")
                .font(.title)
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingView: View {
    var body: some View {
        Text("SettingView")
    }
}

#Preview {
    NavigationStackBootcamp()
}
