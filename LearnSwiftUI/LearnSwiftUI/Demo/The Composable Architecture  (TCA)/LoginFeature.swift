//
//  LoginFeature.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import Foundation

enum LoginFeature: FeatureState {
    // MARK: - 1. State
    struct State: Equatable {
        // Field values
        var email: String = ""
        var password: String = ""

        // Validation errors (nil = no error)
        var emailError: String?    = nil
        var passwordError: String? = nil

        // Touched flags — show error when user interac with input fields
        var emailTouched:    Bool = false
        var passwordTouched: Bool = false

        // Async / network
        var isLoading:  Bool = false
        var loginError: String? = nil
        var isLoggedIn: Bool = false

        // Derived
        var isFormValid: Bool {
            emailError == nil && passwordError == nil
            && !email.isEmpty && !password.isEmpty
        }

        var visibleEmailError: String? {
            emailTouched ? emailError : nil
        }

        var visiblePasswordError: String? {
            passwordTouched ? passwordError : nil
        }
    }
}

extension LoginFeature {
    // MARK: - 2. Action
    enum Action: Equatable {
        // User input — real-time
        case emailChanged(String)
        case passwordChanged(String)

        // Focus events
        case emailDidEndEditing
        case passwordDidEndEditing

        // Submit
        case submitTapped

        // Network response
        case loginResponse(LoginResult)

        // UI
        case dismissLoginError
        case resetForm
    }

}

extension LoginFeature {
    // MARK: - 4. Effect

    enum Effect {
        case login(email: String, password: String)
    }
}

extension LoginFeature {
    // Pure reducer
    static func reduce(_ state: inout State, action: Action) -> Effect? {
        switch action {
            // ── Real-time input
        case .emailChanged(let value):
            state.email = value
            if state.emailTouched {
                state.emailError = Validator.email(value)
            }
            return nil
        case .passwordChanged(let value):
            state.password = value
            if state.passwordTouched {
                state.passwordError = Validator.password(value)
            }
            return nil
            
            // ── Focus / blur
        case .emailDidEndEditing:
            state.emailTouched = true
            state.emailError = Validator.email(state.email)
            return nil
        case .passwordDidEndEditing:
            state.passwordTouched = true
            state.passwordError = Validator.password(state.password)
            return nil
            
            // ── Submit
        case .submitTapped:
            // Force touch both fields to display errors if any
            state.emailTouched    = true
            state.passwordTouched = true
            state.emailError      = Validator.email(state.email)
            state.passwordError   = Validator.password(state.password)
            
            guard state.isFormValid else { return nil }
            
            state.isLoading   = true
            state.loginError  = nil
            return .login(email: state.email, password: state.password)
            
            // ── Network response
        case .loginResponse(.success):
            state.isLoading  = false
            state.isLoggedIn = true
            return nil
            
        case .loginResponse(.failure(let error)):
            state.isLoading   = false
            state.loginError  = error.message
            return nil
            
            // ── UI
        case .dismissLoginError:
            state.loginError = nil
            return nil
            
        case .resetForm:
            state = State()
            return nil
        }
    }
    
    static func handleEffect(_ effect: Effect) async -> Action? {
        switch effect {
        case .login(let email, let password):
            let action = await performLogin(email: email, password: password)
            return action
        }
    }
    
    static private func performLogin(email: String, password: String) async -> Action? {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        // Mock: demo credentials
        if email == "test@example.com" && password == "Password1" {
            return .loginResponse(.success(token: "mock_token_abc"))
        } else {
            return .loginResponse(.failure(.invalidCredentials))
        }
    }
}
