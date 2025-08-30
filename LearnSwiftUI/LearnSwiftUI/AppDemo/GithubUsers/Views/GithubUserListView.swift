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
    
    var body: some View {
        NavigationView {
            VStack {
                userList()
                if viewModel.isLoading {
                    loadingView
                }
            }
            .navigationBarTitle("GitHub Users \(viewModel.users.count)")
        }
        .task { await viewModel.fetchUsers() }
        .refreshable { await viewModel.fetchUsers() }
        .overlay(alignment: .bottom) {
            if let error = viewModel.error {
                ErrorBanner(error: error) {
                    Task { await viewModel.fetchUsers() }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding()
            }
        }
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
        .animation(.default, value: viewModel.users)
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

