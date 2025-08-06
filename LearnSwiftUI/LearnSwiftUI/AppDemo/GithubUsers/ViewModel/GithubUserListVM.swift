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

// MARK: - UserListViewModel Protocol
protocol GithubUserListVMProtocol {
    var users: [GithubUser] { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    func fetchUsers() async
    func loadMoreUser(currentUser: GithubUser) async
    func updatePagination(from users: [GithubUser])
}

class GithubUserListVM: ObservableObject, GithubUserListVMProtocol {
    @Published private(set) var users: [GithubUser] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    private let networkService: GitHubServiceProtocol
    private var paginationConfig: PaginationConfig
    
    init(networkService: GitHubServiceProtocol = GitHubNetworkService(),
         paginationConfig: PaginationConfig = PaginationConfig(perPage: 20, since: 0)) {
        self.networkService = networkService
        self.paginationConfig = paginationConfig
    }
}

extension GithubUserListVM {
    func fetchUsers() async {
        await performWithLoading {
            do {
                var newUsers: [GithubUser] = []
                newUsers = try await networkService.fetchUsers(perPage: paginationConfig.perPage,
                                                               since: paginationConfig.since)
                updateUsers(newUsers)
                updatePagination(from: newUsers)
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
    
    func loadMoreUser(currentUser: GithubUser) async {
        guard let lastUser = users.last, currentUser == lastUser,
              !isLoading,
              !users.isEmpty else { return }
#if DEBUG
        print(">>> Load more data from user withID \(String(describing: currentUser.id))")
#endif
        await performWithLoading {
            do {
                let newUsers = try await networkService.fetchUsers(perPage: paginationConfig.perPage,
                                                                   since: paginationConfig.since)
                appendUsers(newUsers)
                updatePagination(from: newUsers)
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
    
    func updatePagination(from users: [GithubUser]) {
        if let lastUserId = users.last?.id {
            paginationConfig.since = lastUserId
        }
    }
}

// MARK: - Private Helper Methods
extension GithubUserListVM {
    @MainActor
    private func performWithLoading(_ operation: () async throws -> Void) async {
        guard !isLoading else { return }
        isLoading = true
        error = nil
        defer { isLoading = false }
        do {
            try await operation()
        } catch {
            self.error = error
        }
    }
    
    private func updateUsers(_ newUsers: [GithubUser]) {
        DispatchQueue.main.async { [weak self] in
            self?.users = newUsers
        }
    }
    
    private func appendUsers(_ newUsers: [GithubUser]) {
        DispatchQueue.main.async { [weak self] in
            self?.users.append(contentsOf: newUsers)
        }
    }
}
