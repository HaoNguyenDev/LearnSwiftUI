//
//  LoginState.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import Foundation

//// MARK: - 1. State
//struct LoginState: Equatable {
//    // Field values
//    var email: String = ""
//    var password: String = ""
//
//    // Validation errors (nil = no error)
//    var emailError: String?    = nil
//    var passwordError: String? = nil
//
//    // Touched flags — show error when user interac with input fields
//    var emailTouched:    Bool = false
//    var passwordTouched: Bool = false
//
//    // Async / network
//    var isLoading:  Bool = false
//    var loginError: String? = nil
//    var isLoggedIn: Bool = false
//
//    // Derived
//    var isFormValid: Bool {
//        emailError == nil && passwordError == nil
//        && !email.isEmpty && !password.isEmpty
//    }
//
//    var visibleEmailError: String? {
//        emailTouched ? emailError : nil
//    }
//
//    var visiblePasswordError: String? {
//        passwordTouched ? passwordError : nil
//    }
//}
