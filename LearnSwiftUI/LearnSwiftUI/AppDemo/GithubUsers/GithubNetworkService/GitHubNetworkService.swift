//
//  GitHubNetworkService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/8/25.
//

import Combine

// MARK: - GitHubServiceProtocol
protocol GitHubServiceProtocol {
    func fetchUsers(perPage: Int, since: Int) async throws -> [GithubUser]
    func fetchUserDetail(by username: String) async throws -> UserDetail
}

// MARK: - GitHubNetworkService
class GitHubNetworkService: GitHubServiceProtocol {
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GithubUser] {
        let endpoint = GitHubAPIEndpoint.getUsersEndpoint(perPage: perPage, since: since)
        return try await networkManager.fetchData(endpoint: endpoint, responseType: [GithubUser].self)
    }
    
    func fetchUserDetail(by username: String) async throws -> UserDetail {
        let endpoint = GitHubAPIEndpoint.getUserDetailEndpoint(username: username)
        return try await networkManager.fetchData(endpoint: endpoint, responseType: UserDetail.self)
    }
    
    //MARK: Test with other way
    func fetchWithCompletionHandler(perPage: Int, since: Int, completion: @escaping (Result<[GithubUser], Error>) -> Void) {
        let endpoint = GitHubAPIEndpoint.getUsersEndpoint(perPage: perPage, since: since)
        return networkManager.fetchData(endpoint: endpoint, responseType: [GithubUser].self, completion: completion)
    }
    
    func fetchUserWithPublisher(perPage: Int, since: Int) -> AnyPublisher<[GithubUser], Error> {
        let endpoint = GitHubAPIEndpoint.getUsersEndpoint(perPage: perPage, since: since)
        return networkManager.fetchData(endpoint: endpoint, responseType: [GithubUser].self)
    }
}
