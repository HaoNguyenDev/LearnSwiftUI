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
                case .detailView(_):
                    DetailView2(navPath: $navPath, id: Int.random(in: 1...100))
                case .settingView:
                    SettingView2(navPath: $navPath)
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
                navPath.append(Scenes.detailView(id: Int.random(in: 1...100)))
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
        .navigationTitle("Detail View 2")
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
    @Binding var navPath: NavigationPath
    var body: some View {
        VStack(spacing: 30) {
            Text("SettingView")
            
            Button("Back") {
                navPath.removeLast()
            }
            
            Button("Back to Home") {
                navPath = NavigationPath()
            }
            
            .navigationTitle("Setting View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStackBootcamp()
}



//MARK: Custom NavigationPath with custom Items
#Preview {
    NavigationStackCustomItemView()
}

struct Itemview: Hashable, Equatable {
    var id = UUID()
    var itemName: String
}

struct NavigationStackCustomItemView: View {
    
    @State private var navigationPathItems: [Itemview] = []
    
    var body: some View {
        NavigationStack(path: $navigationPathItems) {
            VStack {
                Button("Push to Detail") {
                    navigationPathItems.append(Itemview(itemName: "Detail"))
                }.buttonStyle(.borderedProminent)
                
                Button("Push to Profile") {
                    navigationPathItems.append(Itemview(itemName: "Profile"))
                }.buttonStyle(.borderedProminent)
                
                Button("Push to Setting") {
                    navigationPathItems.append(Itemview(itemName: "Setting"))
                }.buttonStyle(.borderedProminent)
            }
            .navigationTitle("NavigationStackCustomItemView")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Itemview.self) { itemView in
                ItemViewDetail(navigationPathItems: $navigationPathItems, itemView: itemView)
            }
        }
    }
}

struct ItemViewDetail: View {
    @Binding var navigationPathItems: [Itemview]
    var itemView: Itemview
    
    var body: some View {
        VStack(spacing: 30) {
            Text(itemView.itemName)
            Button("Go further") {
                navigationPathItems.append(Itemview(itemName: "Further Detail \(Int.random(in: 1...100))"))
            }.buttonStyle(.borderedProminent)
            
            Button("Back") {
                navigationPathItems.removeLast()
            }.buttonStyle(.borderedProminent)
            
            Button("Back to Home") {
                navigationPathItems = []
            }.buttonStyle(.borderedProminent)
        }
        .navigationTitle(itemView.itemName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
