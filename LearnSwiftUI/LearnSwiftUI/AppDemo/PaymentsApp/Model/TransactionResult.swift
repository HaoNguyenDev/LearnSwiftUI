//
//  TransactionResult.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/9/25.
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
