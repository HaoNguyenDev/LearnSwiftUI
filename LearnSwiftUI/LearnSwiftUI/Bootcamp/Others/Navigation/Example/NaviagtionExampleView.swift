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
    let items = (0...10).map( { Item(name: "Item \($0)")})
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                ForEach(items) { item in
                    Text(item.name)
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
             NavigationExampleDetailView(item: item, onPop: {
                 navPath.removeLast()
             }, onPopToRoot: {
                 navPath.removeLast(navPath.count)
             })
         }
    }
}

struct NavigationExampleDetailView: View {
    let item: Item
    let onPop: VoidResult?
    let onPopToRoot: VoidResult?
    
    var body: some View {
        VStack(spacing: 24.0) {
            Text(item.name)
            Button("pop") {
                onPop?()
            }
            Button("pop to root") {
                onPopToRoot?()
            }
        }
    }
}

#Preview {
    NavigationExampleView()
}
