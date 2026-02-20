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
        contentForState(viewModel.viewState)
            .padding([.top, .bottom])
            .setDefaultBackground()
    }
}

extension GithubUserListView {
    @ViewBuilder
    private func contentForState(_ state: GHListViewState) -> some View {
        GHUserList(users: viewModel.userList, didTapUser: { user in
            fetchUserDetail(for: user)
        }, loadMoreFrom: { user in
            processLoadMore(currentUser: user)
        }).overlay {
            switch viewModel.viewState {
            case .initial:
                Color.clear
            case .loading:
                loadingView
            case .loaded:
                EmptyView()
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
            fetchUser(viewModel.viewState)
        }
        .refreshable {
            fetchUser(viewModel.viewState)
        }
        .onChange(of: viewModel.shouldNavigateToDetail) { oldValue, newDetail in
            if let userDetail = newDetail {
                gotoUserDetail?(userDetail)
                viewModel.shouldNavigateToDetail = nil
            }
        }
    }
    
    private var loadingView: some View {
        ZStack {
            Color.black.opacity(0.1).ignoresSafeArea()
            ProgressView("Loading...")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}


extension GithubUserListView {
    private func fetchUser(_ viewState: GHListViewState) {
        if case .initial = viewState {
            Task {
                await viewModel.fetchUsers()
            }
        }
    }
    
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
    var didTapUser: SingleResult<String?>
    var loadMoreFrom: SingleResult<GithubUser>
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users, id: \.id) { user in
                    UserRowView(user: user, showDetailFor: didTapUser)
                        .onAppear {
                            if user.id == users.last?.id {
                                loadMoreFrom(user)
                            }
                        }
                }
            }
        }
    }
}
