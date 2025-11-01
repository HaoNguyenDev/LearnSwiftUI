//
//  AuthServiceError.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/11/25.
//

import Foundation

enum AuthServiceError: Error, LocalizedError {
    case missingToken
    case loginFailed(Error)
    case refreshTokenFailed
    case retryHandlerMissingToken
    
    var errorDescription: String? {
        switch self {
        case .missingToken: return "Token not found. Please log in again."
        case .loginFailed(let error): return "Login failed with error: \(error.localizedDescription)."
        case .refreshTokenFailed: return "Token refresh failed. Refresh token expired or invalid."
        case .retryHandlerMissingToken: return "Retry handler missing token. Please log in again."
        }
    }
}
