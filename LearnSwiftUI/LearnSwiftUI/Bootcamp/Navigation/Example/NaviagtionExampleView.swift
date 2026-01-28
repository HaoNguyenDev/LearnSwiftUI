//
//  NaviagtionExampleView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 28/1/26.
//

import SwiftUI

enum NavigationExampleRoute: Hashable {
    case detail(Item)
}

struct NavigationExampleView: View {
    @State private var navPath = NavigationPath()
    let items = (0...10).map( { Item(title: "Item \($0)")})
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                ForEach(items) { item in
                    Text(item.title)
                        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            navPath.append(NavigationExampleRoute.detail(item))
                        }
                }
            }
            .listStyle(.plain)
            
            .navigationDestination(for: NavigationExampleRoute.self, destination: { route in
                viewForRoute(route: route)
            })
            .navigationTitle("NaviagtionExampleView")
        }
    }
}

extension NavigationExampleView {
     private func viewForRoute(route: NavigationExampleRoute) -> some View {
         switch route {
         case .detail(let item):
             NavigationExampleDetailView(navPath: $navPath, item: item)
         }
    }
}

struct NavigationExampleDetailView: View {
    @Binding var navPath: NavigationPath
    let item: Item
    
    var body: some View {
        VStack(spacing: 24.0) {
            Text(item.title)
            Button("pop") {
                navPath.removeLast()
            }
            Button("pop to root") {
                navPath.removeLast(navPath.count)
            }
        }
    }
}

#Preview {
    NavigationExampleView()
}
