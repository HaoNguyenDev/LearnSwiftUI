//
//  ResultAndError.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/9/25.
//
import Foundation

struct TransactionResult {
    let transactionId: String
    let transactionType: String
    let amount: Double
    let currency: String
    let status: Bool
    let message: String?
    let error: String?
    let createdAt: Date
    let updatedAt: Date?
    let expiration: Date?
    let metadata: [String: Any]?
    let provider: String?
}

enum TransactionError: Error {
    case invalidAmount(Double)
    case insufficientFunds(Double)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidAmount(let amount):
            return "Invalid amount: \(amount)"
        case .insufficientFunds(let amount):
            return "Insufficient funds: \(amount)"
        case .unknown:
            return "Unknown error"
        }
    }
}
