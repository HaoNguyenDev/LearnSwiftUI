//
//  NavigationPathExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/1/26.
//

import SwiftUI

enum RouteExample: Hashable {
    case page1
    case page2
    case home
}

struct NavigationPathExample: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Goto Page 1") {
                    path.append(RouteExample.page1)
                }
                
                Button("Goto Page 2") {
                    path.append(RouteExample.page2)
                }
            }
            .navigationDestination(for: RouteExample.self) { value in
                switch value {
                case .page1:
                    Page1Example(path: $path)
                case .page2:
                    Page2Example(path: $path)
                default:
                    EmptyView()
                }
            }
            .navigationTitle("NavigationPathExample")
        }
    }
}

struct Page1Example: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 24.0) {
            Button("push to Page 2") {
                path.append(RouteExample.page2)
            }
            
            Button("pop") {
                path.removeLast()
            }
            
            Button("pop to root") {
                path.removeLast(path.count)
            }
        }
        .navigationDestination(for: String.self) { value in
            if value == "page2" {
                Page2Example(path: $path)
            }
        }
        .navigationTitle("Page 1")
    }
}

struct Page2Example: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 24.0) {
            Button("pop") {
                path.removeLast()
            }
            Button("pop to root") {
                path.removeLast(path.count)
            }
        }
        .navigationTitle("Page 2")
    }
}

#Preview {
    NavigationPathExample()
}
