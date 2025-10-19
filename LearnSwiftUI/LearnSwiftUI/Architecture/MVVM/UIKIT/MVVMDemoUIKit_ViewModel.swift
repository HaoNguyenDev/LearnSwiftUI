//
//  MVVMDemoUIKit_ViewModel.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/10/25.
//

import Foundation
import Combine

class MVVMDemoUIKit_ViewModel: ViewModelTransformableProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input/Output Structs
    struct Input {
        let inputString: AnyPublisher<String?, Never>
        let viewDidloadTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let errorResult: AnyPublisher<Error, Never>
        let stringResult: AnyPublisher<String?, Never>
        let userListResult: AnyPublisher<[GithubUser], Never>
    }
    
    // MARK: - Internal Subjects
    private var inputStringSubject = PassthroughSubject<String?, Never>()
    private let errorSubject = PassthroughSubject<Error, Never>()
    private let userListSubject = CurrentValueSubject<[GithubUser], Never>([])
    
    init() {}
    
    // MARK: - Transform
    func transform(input: Input) -> Output {
        
        input.inputString
            .sink(receiveValue: { [weak self] string in
                self?.inputStringSubject.send(string)
            }).store(in: &cancellables)
           
        
        let userListPublisher = input.viewDidloadTrigger
            .flatMap { [weak self] _ -> AnyPublisher<[GithubUser], Error> in
                guard let self else {
                    return Empty(completeImmediately: true).eraseToAnyPublisher()
                }
                return self.fetchUsers()
            }
            .catch { [weak self] error -> Empty<[GithubUser], Never> in
                self?.errorSubject.send(error)
                return Empty(completeImmediately: true)
            }
            .eraseToAnyPublisher()
        
        userListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.userListSubject.send(users)
            }
            .store(in: &cancellables)
        
        return Output(errorResult: errorSubject.eraseToAnyPublisher(),
                      stringResult: inputStringSubject.eraseToAnyPublisher(),
                      userListResult: userListSubject.eraseToAnyPublisher())
    }
    
    private func fetchUsers() -> AnyPublisher<[GithubUser], Error> {
        
        guard let url = URL(string: "https://api.github.com/users") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                let _ = try self.handleHTTPResponse(response: response)
                return data
            }
            .decode(type: [GithubUser].self, decoder: JSONDecoder())
            .mapError { error -> Error in
                switch error {
                case let networkError as NetworkError:
                    return networkError
                case is DecodingError:
                    return NetworkError.decodingError(error: error)
                case let urlError as URLError:
                    return NetworkError.networkError(error: urlError)
                default:
                    return NetworkError.networkError(error: error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func handleHTTPResponse(response: URLResponse?) throws -> HTTPURLResponse {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(statusCode: 0)
        }
        
        let statusCode = httpResponse.statusCode
        
        switch statusCode {
        case 200..<300:
            return httpResponse
        case 400..<500:
            throw NetworkError.clientError(statusCode: statusCode)
        case 500..<600:
            throw NetworkError.serverError(statusCode: statusCode)
        default:
            throw NetworkError.unknownError(statusCode: statusCode)
        }
    }
}
