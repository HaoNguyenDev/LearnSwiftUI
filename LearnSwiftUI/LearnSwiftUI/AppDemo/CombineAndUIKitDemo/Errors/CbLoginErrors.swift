//
//  CbLogginErrors.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/10/25.
//

import Foundation

enum CbLoginPasswordError: Error {
    case incorrect
    case empty
    case wrongLength
    
    var localizedDescription: String {
        switch self {
        case .incorrect:
            return "Incorrect password format"
        case .empty:
            return "Password can't be empty"
        case .wrongLength:
            return "Password must be at least 6 characters long"
        }
    }
}

enum CbLoginEmailError: Error {
    case incorrectFormat
    case empty
    
    var localizedDescription: String {
        switch self {
        case .incorrectFormat:
            return "Invalid email format"
        case .empty:
            return "Email can't be empty"
        }
    }
}

enum CbLoginError: Error {
    case failed
    case success
    case custom(String)
    var localizedDescription: String {
        switch self {
        case .failed:
            return "Login failed"
        case .success:
            return "Login success"
        case .custom(let message):
            return message
        }
    }
}
