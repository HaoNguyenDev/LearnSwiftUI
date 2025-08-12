//
//  GithubUserListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/8/25.
//

import Foundation
import SwiftUI

struct GithubUserListView: View {
    @State private var viewModel = GithubUserListVM()
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                userList()
                if viewModel.isLoading {
                    loadingView
                }
            }
            .navigationBarTitle("GitHub Users \(viewModel.users.count)")
        }
        .task {
            await viewModel.fetchUsers()
        }
//        .onReceive(viewModel.$error) { error in
//            if error != nil {
//                showErrorAlert = true
//            }
//        }
        .onChange(of: viewModel.error as? NetworkError, { _, error in
            if error != nil {
                showErrorAlert = true
            }
        })
        .modifier(AlertHandler(showAlert: $showErrorAlert, error: viewModel.error, onDismiss: {
            showErrorAlert = false
        }))
    }
    
    private func processLoadMore(currentUser user: GithubUser) {
        Task {
            await viewModel.loadMoreUser(currentUser: user)
        }
    }
    
    @ViewBuilder
    private func userList() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.users) { user in
                    UserRowView(user: user)
                        .padding()
                        .onAppear {
                            processLoadMore(currentUser: user)
                        }
                }
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding()
    }
}

#Preview {
    GithubUserListView()
}

