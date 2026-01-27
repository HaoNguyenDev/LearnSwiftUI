//
//  NavigationPathExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/1/26.
//

import SwiftUI

struct NavigationPathExample: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Goto Page 1") {
                    path.append("page1")
                }
                
                Button("Goto Page 2") {
                    path.append("page2")
                }
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "page1":
                    Page1Example(path: $path)
                case "page2":
                    Page2Example()
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
        Text("Page 1")
    }
}

struct Page2Example: View {
    var body: some View {
        Text("Page 2")
    }
}

#Preview {
    NavigationPathExample()
}
