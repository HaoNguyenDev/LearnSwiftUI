//
//  UserListViewModel.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/10/25.
//
import UIKit
import Combine

// MARK: - User ViewModel
class UserListViewModel {
    
    let usersPublisher = CurrentValueSubject<[GithubUser], Never>([])
    
    // State variable to manage Load More
    private var lastUserID: Int = 0
    private let perPageLimit = 30
    private var cancellables = Set<AnyCancellable>() // Store subscription
    private let githubNetworkService: GitHubServiceProtocol
    
    init(githubNetworkService: GitHubServiceProtocol = GitHubNetworkService()) {
        self.githubNetworkService = githubNetworkService
    }
    
    func loadUsers(isLoadMore: Bool) {
        
        let currentSince = isLoadMore ? lastUserID : 0
        
        githubNetworkService.fetchUserWithPublisher(perPage: perPageLimit, since: currentSince)
            .receive(on: DispatchQueue.main) // Change thread to Main Thread for update UI
            .sink { completion in
                switch completion {
                case .finished:
                    Logger.shared.debug("Finish load user list")
                case .failure(let error):
                    Logger.shared.debug("Error: \(error.localizedDescription)")
                    // TODO: Show error
                }
            } receiveValue: { [weak self] newUsers in
                guard let self = self else { return }
                
                if let lastUser = newUsers.last {
                    self.lastUserID = lastUser.id ?? 0
                }

                if isLoadMore {
                    var currentUsers = self.usersPublisher.value
                    currentUsers.append(contentsOf: newUsers)
                    self.usersPublisher.send(currentUsers)
                } else {
                    self.usersPublisher.send(newUsers)
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchNextPage() {
        loadUsers(isLoadMore: true)
    }
}
