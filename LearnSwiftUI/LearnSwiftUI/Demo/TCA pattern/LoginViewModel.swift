//
//  LoginViewModel.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import SwiftUI

// MARK: - 5. ViewModel
@MainActor
final class LoginViewModel: ObservableObject {
    @Published private(set) var state = LoginState()
    private let reducer = LoginReducer()

    // MARK: Send
    func send(_ action: LoginAction) {
        let effect = reducer.reduce(&state, action: action)
        handleEffect(effect)
    }

    // MARK: Binding helper
    func binding<Value>(
        get keyPath: KeyPath<LoginState, Value>,
        send toAction: @escaping (Value) -> LoginAction
    ) -> Binding<Value> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.send(toAction($0)) }
        )
    }
}

// MARK: Effect Handler (side-effects isolated here)
private extension LoginViewModel {
    func handleEffect(_ effect: LoginEffect?) {
        guard let effect else { return }
        switch effect {
        case .login(let email, let password):
            Task { await performLogin(email: email, password: password) }
        }
    }

    private func performLogin(email: String, password: String) async {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_500_000_000)

        // Mock: demo credentials
        if email == "test@example.com" && password == "Password1" {
            send(.loginResponse(.success(token: "mock_token_abc")))
        } else {
            send(.loginResponse(.failure(.invalidCredentials)))
        }
    }
}
