//
//  CbLoginViewModel.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/10/25.
//

import Foundation
import Combine

// MARK: - ViewModel
final class CbLoginViewModel: ViewModelTransformableProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let email: AnyPublisher<String, Never>
        let password: AnyPublisher<String, Never>
        let loginButtonTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let isLoading: AnyPublisher<Bool, Never>
        let isEnableLoginButton: AnyPublisher<Bool, Never>
        let loginResult: AnyPublisher<CbLoginResult?, Never>
        let error: AnyPublisher<Error?, Never>
    }
    
    // Internal Subjects
    private let isLoadingSubject = PassthroughSubject<Bool, Never>()
    private let isLoginResultSubject = PassthroughSubject<CbLoginResult?, Never>()
    private let errorSubject = PassthroughSubject<Error?, Never>()
    
    init() {}
    
    func transform(input: Input) -> Output {
        // Validate email stream
        let emailValidation = input.email
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .flatMap { [weak self] email -> AnyPublisher<Bool, Never> in
                guard let self = self else { return Just(false).eraseToAnyPublisher() }
                return self.validEmail(with: email)
                    .handleEvents(receiveCompletion: { [weak self] completion in
                        guard let self else { return }
                        if case let .failure(error) = completion {
                            self.errorSubject.send(error)
                        } else {
                            self.errorSubject.send(nil)
                        }
                    })
                    .replaceError(with: false)
                    .eraseToAnyPublisher()
            }
            .share()
            .eraseToAnyPublisher()
        
        // Validate password stream
        let passwordValidation = input.password
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .flatMap { [weak self] password -> AnyPublisher<Bool, Never> in
                guard let self else { return Just(false).eraseToAnyPublisher() }
                return self.validPassword(with: password)
                    .handleEvents(receiveCompletion: { [weak self] completion in
                        guard let self else { return }
                        if case let .failure(error) = completion {
                            self.errorSubject.send(error)
                        } else {
                            self.errorSubject.send(nil)
                        }
                    })
                    .replaceError(with: false)
                    .eraseToAnyPublisher()
            }
            .share()
            .eraseToAnyPublisher()
        
        // Combine email + password validity
        let isEnableLogin = emailValidation
            .combineLatest(passwordValidation)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
        
        // Handle login trigger
        input.loginButtonTrigger
            .withLatestFrom(isEnableLogin)
            .filter { $0 } // Only login if form is valid
            .sink { [weak self] _ in
                guard let self else { return }
                self.login()
                    .subscribe(on: DispatchQueue.global())
                    .sink { [weak self] completion in
                        guard let self else { return }
                        self.isLoadingSubject.send(false)
                        if case .failure(let error) = completion {
                            self.errorSubject.send(error)
                        }
                    } receiveValue: { [weak self] result in
                        guard let self else { return }
                        self.isLoginResultSubject.send(result)
                    }
                    .store(in: &cancellables)
                
            }
            .store(in: &cancellables)
        
        return Output(
            isLoading: isLoadingSubject.eraseToAnyPublisher(),
            isEnableLoginButton: isEnableLogin,
            loginResult: isLoginResultSubject.eraseToAnyPublisher(),
            error: errorSubject.eraseToAnyPublisher()
        )
    }
    
    // MARK: - Login Simulation
    
    private func login() -> AnyPublisher<CbLoginResult?, Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self else { return }
                self.isLoadingSubject.send(true)
                let success = Bool.random()
                DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: {
                    if success {
                        let result = CbLoginResult(isSuccess: true, error: nil, token: "tokenAda34532m2345fas")
                        promise(.success(result))
                    } else {
                        promise(.failure(CbLoginError.failed))
                    }
                })
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    // MARK: - Validators
    
    private func validEmail(with email: String) -> AnyPublisher<Bool, Error> {
        if email.isEmpty {
            return Fail(error: CbLoginEmailError.empty).eraseToAnyPublisher()
        }
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        guard email.range(of: regex, options: .regularExpression) != nil else {
            return Fail(error: CbLoginEmailError.incorrectFormat).eraseToAnyPublisher()
        }
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    private func validPassword(with password: String) -> AnyPublisher<Bool, Error> {
        if password.isEmpty {
            return Fail(error: CbLoginPasswordError.empty).eraseToAnyPublisher()
        }
        if password.count < 6 {
            return Fail(error: CbLoginPasswordError.wrongLength).eraseToAnyPublisher()
        }
        let regex = "^(?=.*[a-zA-Z])(?=.*\\d).{6,}$"
        guard password.range(of: regex, options: .regularExpression) != nil else {
            return Fail(error: CbLoginPasswordError.incorrect).eraseToAnyPublisher()
        }
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}

extension Publisher {
    func withLatestFrom<Other: Publisher>(_ other: Other) -> AnyPublisher<Other.Output, Failure> where Other.Failure == Failure {
        other
            .flatMap { latest in
                self.map { _ in latest }
            }
            .eraseToAnyPublisher()
    }
}
