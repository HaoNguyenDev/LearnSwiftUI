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
    func fetchUserDetail(by username: String) async throws -> GithubUserDetail
    func fetchUserWithPublisher(perPage: Int, since: Int) -> AnyPublisher<[GithubUser], Error>
}

// MARK: - GitHubNetworkService
class GitHubNetworkService: GitHubServiceProtocol {
    private let networkManager: NetworkServiceProtocol
    
    init(networkManager: NetworkServiceProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GithubUser] {
        let endpoint = GithubAPIEndpoint.getUsersEndpoint(perPage: perPage, since: since)
        return try await networkManager.requestAsync(endpoint: endpoint)
    }
    
    func fetchUserDetail(by username: String) async throws -> GithubUserDetail {
        let endpoint = GithubAPIEndpoint.getUserDetailEndpoint(username: username)
        return try await networkManager.requestAsync(endpoint: endpoint)
    }
    
    //MARK: Test with other way
    func fetchWithCompletionHandler(perPage: Int, since: Int, completion: @escaping (Result<[GithubUser], Error>) -> Void) {
        let endpoint = GithubAPIEndpoint.getUsersEndpoint(perPage: perPage, since: since)
        return networkManager.requestCallback(endpoint: endpoint, completion: completion)
    }
    
    func fetchUserWithPublisher(perPage: Int, since: Int) -> AnyPublisher<[GithubUser], Error> {
        let endpoint = GithubAPIEndpoint.getUsersEndpoint(perPage: perPage, since: since)
        return networkManager.requestPublisher(endpoint: endpoint)
    }
}
