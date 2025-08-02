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

struct NavigationStackBootcamp: View {
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) { // NavigationStack look the changes of $navigationPath
            VStack(spacing: 30) {
                Text("Home View")
                    .font(.largeTitle)
                
                Button("Go to Detail") {
                    navPath.append(Scenes.detailView(id: 10)) //Add view want to navigate to path
                }
                
                Button("Go to Setting") {
                    navPath.append(Scenes.settingView)
                }
                
                Button("Go to Profile") {
                    navPath.append(Scenes.profileView)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            
            // Destination manages changes from navigationPath to navigate to destination view
            .navigationDestination(for: Scenes.self) { view in
                switch view {
                case .detailView:
                    DetailView2(navPath: $navPath, id: Int.random(in: 1...10))
                case .settingView:
                    SettingView2()
                case .profileView:
                    Text("Profile View")
                }
            }
            
        }
    }
}

struct DetailView2: View {
    @Binding var navPath: NavigationPath
    let id: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Details of ID: \(id)")
                .font(.title)
            
            Button("Go further") {
                navPath.append(Scenes.detailView(id: 11))
            }
            
            Button("Back") {
                navPath.removeLast() // removeLast(2) number are how many view ypu want to back
            }
            
            Button {
                navPath = NavigationPath() // this one mean back to rootview
            } label: {
                Text("Back to Home")
            }
     
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {                          // custom ToolbarItem with image or test or any view
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { navPath = NavigationPath() }) {
                    Image(systemName: "arrowshape.left.fill")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { navPath = NavigationPath() }) {
                    Image(systemName: "house")
                }.buttonStyle(.borderedProminent)
            }
        }
    }
}

struct SettingView2: View {
    var body: some View {
        Text("SettingView")
            .navigationTitle("Setting View")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStackBootcamp()
}
