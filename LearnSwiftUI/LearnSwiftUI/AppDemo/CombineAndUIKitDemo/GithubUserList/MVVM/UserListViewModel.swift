//
//  UserListViewModel.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/10/25.
//
import UIKit
import Combine

//MARK: Way 2

// MARK: - User ViewModel
class UserListViewModel: ViewModelTransformableProtocol {
    
    // State variable to manage Load More
    private var lastUserID: Int = 0
    private let perPageLimit = 30
    private var cancellables = Set<AnyCancellable>() // Store subscription
    private let githubNetworkService: GitHubServiceProtocol
    
    // MARK: - Input/Output Structs
    struct Input {
        let viewDidLoadTrigger: AnyPublisher<Void, Never>
        let fetchNextPageTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let users: AnyPublisher<[GithubUser]?, Never>
        let error: AnyPublisher<Error?, Never>
    }
    
    // MARK: - Internal Subjects
    private let errorSubject = PassthroughSubject<Error?, Never>()
    private let usersSubject = CurrentValueSubject<[GithubUser]?, Never>(nil)
    
    init(githubNetworkService: GitHubServiceProtocol = GitHubNetworkService()) {
        self.githubNetworkService = githubNetworkService
    }
    
    // MARK: - Transform
    func transform(input: Input) -> Output {
        
        input.viewDidLoadTrigger
            .sink { [weak self] in
                guard let self else { return }
                self.loadUsers(isLoadMore: false)
            }
            .store(in: &cancellables)
        
        input.fetchNextPageTrigger
            .sink { [weak self] in
                guard let self else { return }
                self.loadUsers(isLoadMore: true)
            }.store(in: &cancellables)
        
        return Output(users: usersSubject.eraseToAnyPublisher(),
                      error: errorSubject.eraseToAnyPublisher())
    }
    
    // MARK: - Private Logic
    private func loadUsers(isLoadMore: Bool) {
        
        let currentSince = isLoadMore ? lastUserID : 0
        
        githubNetworkService.fetchUserWithPublisher(perPage: perPageLimit, since: currentSince)
            .receive(on: DispatchQueue.main) // Change thread to Main Thread for update UI
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    Logger.shared.debug("Finish load user list")
                    self.errorSubject.send(nil)
                case .failure(let error):
                    Logger.shared.debug("Error: \(error.localizedDescription)")
                    self.errorSubject.send(error)
                }
            }
            receiveValue: { [weak self] (newUsers: [GithubUser]) in
                guard let self = self else { return }
                
                if let lastUser = newUsers.last {
                    self.lastUserID = lastUser.id ?? 0
                }

                if isLoadMore {
                    var currentUsers = self.usersSubject.value ?? []
                    currentUsers.append(contentsOf: newUsers)
                    self.usersSubject.send(currentUsers)
                } else {
                    self.usersSubject.send(newUsers)
                }
            }
            .store(in: &cancellables)
    }
}

//MARK: Way 1

//// MARK: - User ViewModel
//class UserListViewModel {
//    
//    // Publisher food data for UI access
//    let usersPublisher = CurrentValueSubject<[GithubUser], Never>([])
//    let errorPublisher = PassthroughSubject<Error, Never>()
//    
//    // State variable to manage Load More
//    private var lastUserID: Int = 0
//    private let perPageLimit = 30
//    private var cancellables = Set<AnyCancellable>() // Store subscription
//    private let githubNetworkService: GitHubServiceProtocol
//    
//    init(githubNetworkService: GitHubServiceProtocol = GitHubNetworkService()) {
//        self.githubNetworkService = githubNetworkService
//    }
//    
//    func loadUsers(isLoadMore: Bool) {
//        
//        let currentSince = isLoadMore ? lastUserID : 0
//        
//        githubNetworkService.fetchUserWithPublisher(perPage: perPageLimit, since: currentSince)
//            .receive(on: DispatchQueue.main) // Change thread to Main Thread for update UI
//            .sink { [weak self] completion in
//                switch completion {
//                case .finished:
//                    Logger.shared.debug("Finish load user list")
//                case .failure(let error):
//                    Logger.shared.debug("Error: \(error.localizedDescription)")
//                    // TODO: Show error
//                    self?.errorPublisher.send(error)
//                }
//            } receiveValue: { [weak self] newUsers in
//                guard let self = self else { return }
//                
//                if let lastUser = newUsers.last {
//                    self.lastUserID = lastUser.id ?? 0
//                }
//
//                if isLoadMore {
//                    var currentUsers = self.usersPublisher.value
//                    currentUsers.append(contentsOf: newUsers)
//                    self.usersPublisher.send(currentUsers)
//                } else {
//                    self.usersPublisher.send(newUsers)
//                }
//            }
//            .store(in: &cancellables)
//    }
//    
//    func fetchNextPage() {
//        loadUsers(isLoadMore: true)
//    }
//}
