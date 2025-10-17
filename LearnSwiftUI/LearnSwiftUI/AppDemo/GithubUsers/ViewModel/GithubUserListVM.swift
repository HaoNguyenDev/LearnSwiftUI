//
//  GithubUserListVM.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 4/8/25.
//
import SwiftUI

// MARK: - Support for Loadmore
struct PaginationConfig {
    var perPage: Int
    var since: Int
}

// MARK: - New View State
enum GHListViewState: Equatable {
    case initial
    case loading
    case loaded
    case error(Error)
    
    static func == (lhs: GHListViewState, rhs: GHListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial), (.loading, .loading), (.loaded, .loaded):
            return true
        case (.error(let lError), .error(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        default:
            return false
        }
    }
}

// MARK: - GithubUserListVM Protocol (Cập nhật)
protocol GithubUserListVMProtocol {
    var viewState: GHListViewState { get }
    
    func fetchUsers() async
    func fetchUserDetail(username: String?) async
    func loadMoreUser(currentUser: GithubUser) async
    func updatePagination(from users: [GithubUser])
}

class GithubUserListVM: ObservableObject, GithubUserListVMProtocol {
    
    @Published var userList: [GithubUser] = []
    @Published private(set) var viewState: GHListViewState = .initial
    @Published var shouldNavigateToDetail: GithubUserDetail? = nil
    
    private let networkService: GitHubServiceProtocol
    private var paginationConfig: PaginationConfig
    
    init(networkService: GitHubServiceProtocol = GitHubNetworkService(),
         paginationConfig: PaginationConfig = PaginationConfig(perPage: 20, since: 0)) {
        self.networkService = networkService
        self.paginationConfig = paginationConfig
    }
}

extension GithubUserListVM {
    
    @MainActor
    func fetchUsers() async {
        viewState = .loading
        do {
            let newUsers = try await networkService.fetchUsers(perPage: paginationConfig.perPage, since: 0)
            Logger.shared.debug("Since: \(paginationConfig.since)")
            viewState = .loaded
            await MainActor.run {
                userList = newUsers
            }
            updatePagination(from: newUsers)
        } catch {
            viewState = .error(error)
        }
        
//        do {
//            guard let url = URL(string: "https://api.github.com/users") else { return }
//            let (data, _) = try await URLSession.shared.data(from: url)
//            try await MainActor.run {
//                let jsonDecoder = JSONDecoder()
//                let users = try jsonDecoder.decode([GithubUser].self, from: data)
//                Logger.shared.debug("Fetched \(users.count) users")
//            }
//        } catch {
//            viewState = .error(error)
//        }
    }
    
    @MainActor
    func loadMoreUser(currentUser: GithubUser) async {
        guard let lastUser = userList.last, currentUser.id == lastUser.id else { return }
        guard case .loaded = viewState else { return }
        Logger.shared.debug(">>> Load more data from user withID \(String(describing: currentUser.id))")
//        viewState = .loading
        do {
            let newUsers = try await networkService.fetchUsers(perPage: paginationConfig.perPage,
                                                               since: paginationConfig.since)
            await updateNewUsers(newUsers)
            updatePagination(from: newUsers)
        } catch {
            viewState = .error(error)
        }
    }
    
    private func updateNewUsers(_ newUsers: [GithubUser]) async {
        await MainActor.run { [weak self] in
            self?.userList.append(contentsOf: newUsers)
            self?.viewState = .loaded
        }
    }
    
    func updatePagination(from users: [GithubUser]) {
        if let lastUserId = users.last?.id {
            paginationConfig.since = lastUserId
        }
    }
    
    @MainActor
    func fetchUserDetail(username: String?) async {
        guard let username = username, !username.isEmpty else {
            return
        }
        
        do {
            let userDetail = try await networkService.fetchUserDetail(by: username)
            viewState = .loaded
            shouldNavigateToDetail = userDetail
        } catch {
            viewState = .error(error)
        }
    }
    
}

