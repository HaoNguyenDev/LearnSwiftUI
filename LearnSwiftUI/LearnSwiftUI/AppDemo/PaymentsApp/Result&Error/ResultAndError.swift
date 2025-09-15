//
//  ResultAndError.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/9/25.
//
import Foundation

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
