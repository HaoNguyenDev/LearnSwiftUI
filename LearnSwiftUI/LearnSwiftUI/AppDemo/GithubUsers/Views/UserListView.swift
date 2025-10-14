//
//  UserListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/8/25.
//

import SwiftUI

struct GithubUserListView: View {
    @ObservedObject private(set) var viewModel: GithubUserListVM
    var gotoUserDetail: SingleResult<GithubUserDetail>?
    @State private var navigate = false
    
    var body: some View {
        contentView()
            .padding([.top, .bottom])
            .setDefaultBackground()
    }
}

extension GithubUserListView {
    @ViewBuilder
    func contentView() -> some View {
        ZStack {
            switch viewModel.viewState {
            case .initial:
                Color.clear
            case .loading:
                loadingView
            case .loaded:
                GHUserList(users: viewModel.userList, didTapUser: { user in
                    fetchUserDetail(for: user)
                }, loadMoreFrom: { user in
                    processLoadMore(currentUser: user)
                })
            case .error(let error):
                ErrorBanner(error: error) {
                    Task {
                        await viewModel.fetchUsers()
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding()
            }
        }
        .onAppear() {
            if case .initial = viewModel.viewState {
                Task {
                    await viewModel.fetchUsers()
                }
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchUsers()
            }
        }
        .onChange(of: viewModel.shouldNavigateToDetail) { oldValue, newDetail in
            if let userDetail = newDetail {
                gotoUserDetail?(userDetail)
                viewModel.shouldNavigateToDetail = nil
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding()
    }
}


extension GithubUserListView {
    private func processLoadMore(currentUser user: GithubUser) {
        Task {
            await viewModel.loadMoreUser(currentUser: user)
        }
    }
    
    private func fetchUserDetail(for login: String?) {
        Task {
            await viewModel.fetchUserDetail(username: login)
        }
    }
}

#Preview {
    GithubUserListView(viewModel: GithubUserListVM(), gotoUserDetail: nil)
}


struct GHUserList: View {
    var users: [GithubUser]
    var didTapUser: SingleResult<String?>?
    var loadMoreFrom: SingleResult<GithubUser>?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    UserRowView(user: user)
                        .padding()
                        .onAppear {
                            loadMoreFrom?(user)
                        }
                        .onTapGesture {
                            didTapUser?(user.login)
                        }
                }
            }
        }
    }
}
