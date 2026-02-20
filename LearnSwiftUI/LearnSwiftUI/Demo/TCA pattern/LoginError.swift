//
//  LoginError.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

enum LoginError: Error, Equatable {
    case invalidCredentials
    case networkError
    case unknown

    var message: String {
        switch self {
        case .invalidCredentials: return "Incorrect email or password"
        case .networkError: return "Connection error, please try again"
        case .unknown: return "An error occurred"
        }
    }
}

