//
//  AppCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

struct AppCoordinator: View {
    @State private var rootRouter = NavRouter()
    var body: some View {
        contentView
    }
    
    @ViewBuilder
    var contentView: some View {
        NavigationStack(path: $rootRouter.path) {
            BootcampListCoordinator(navRouter: rootRouter)
        }
        .ignoresSafeArea()
    }
}
