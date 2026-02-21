//
//  LoginReducer.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

// MARK: - 3. Reducer

///// Pure function: (State, Action) → (newState, Effect?)
//struct LoginReducer {
//    func reduce(_ state: inout LoginState, action: LoginAction) -> LoginEffect? {
//        switch action {
//            // ── Real-time input
//        case .emailChanged(let value):
//            state.email = value
//            if state.emailTouched {
//                state.emailError = Validator.email(value)
//            }
//            return nil
//        case .passwordChanged(let value):
//            state.password = value
//            if state.passwordTouched {
//                state.passwordError = Validator.password(value)
//            }
//            return nil
//            
//            // ── Focus / blur
//        case .emailDidEndEditing:
//            state.emailTouched = true
//            state.emailError = Validator.email(state.email)
//            return nil
//        case .passwordDidEndEditing:
//            state.passwordTouched = true
//            state.passwordError = Validator.password(state.password)
//            return nil
//            
//            // ── Submit
//        case .submitTapped:
//            // Force touch both fields to display errors if any
//            state.emailTouched    = true
//            state.passwordTouched = true
//            state.emailError      = Validator.email(state.email)
//            state.passwordError   = Validator.password(state.password)
//            
//            guard state.isFormValid else { return nil }
//            
//            state.isLoading   = true
//            state.loginError  = nil
//            return .login(email: state.email, password: state.password)
//            
//            // ── Network response
//        case .loginResponse(.success):
//            state.isLoading  = false
//            state.isLoggedIn = true
//            return nil
//            
//        case .loginResponse(.failure(let error)):
//            state.isLoading   = false
//            state.loginError  = error.message
//            return nil
//            
//            // ── UI
//        case .dismissLoginError:
//            state.loginError = nil
//            return nil
//            
//        case .resetForm:
//            state = LoginState()
//            return nil
//        }
//    }
//}
//
//// MARK: - 4. Effect
//
//enum LoginEffect {
//    case login(email: String, password: String)
//}
