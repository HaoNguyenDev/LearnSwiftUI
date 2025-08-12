//
//  NetworkError.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/8/25.
//

import Foundation

// MARK: - Custom NetworkError
enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidData
    case invalidResponse(statusCode: Int)
    case decodingError(error: Error)
    case networkError(error: Error)
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknownError(statusCode: Int)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidData:
            return "Invalid Data"
        case .invalidResponse(let statusCode):
            return "Invalid Response: \(statusCode)"
        case .clientError(let statusCode):
            return "Client Error: \(statusCode)"
        case .serverError(let statusCode):
            return "Server Error: \(statusCode)"
        case .decodingError(error: let error):
            return "Decoding Error: \(error.localizedDescription)"
        case .networkError(error: let error):
            return "Network Error: \(error.localizedDescription)"
        case .unknownError(let statusCode):
            return "Unknown Error Code: \(statusCode)"
        }
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidData, .invalidData):
            return false
        case let (.invalidResponse(lhsCode), .invalidResponse(rhsCode)),
             let (.clientError(lhsCode), .clientError(rhsCode)),
             let (.serverError(lhsCode), .serverError(rhsCode)),
             let (.unknownError(lhsCode), .unknownError(rhsCode)):
            return lhsCode == rhsCode
        case let (.decodingError(lhsError), .decodingError(rhsError)),
             let (.networkError(lhsError), .networkError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

enum AppError: Error {
    case generic(String)
    case custom(Error)
}
