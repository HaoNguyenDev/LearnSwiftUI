//
//  ThaiPaymentService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//
import Foundation

class ThaiPaymentService: PaymentServiceProtocol {
    private let baseURL = URL(string: "https://api.thai-payment.com")!
    
    func deposit(_ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void) {
        // call network service with thailand payment url
        completion(.success(TransactionResult(transactionId: UUID().uuidString,
                                              transactionType: "deposit",
                                              amount: amount,
                                              currency: "thb",
                                              status: true,
                                              message: "Deposit successfully",
                                              error: nil,
                                              createdAt: Date(),
                                              updatedAt: Date(),
                                              expiration: nil,
                                              metadata: nil,
                                              provider: "Kbank")))
    }
    
    func transfer(_ toRecipient: String, _ amount: Double, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        completion(.success(TransactionResult(transactionId: UUID().uuidString,
                                              transactionType: "transfer",
                                              amount: amount,
                                              currency: "thb",
                                              status: true,
                                              message: "Transfer successfully",
                                              error: nil,
                                              createdAt: Date(),
                                              updatedAt: Date(),
                                              expiration: nil,
                                              metadata: nil,
                                              provider: "Kbank")))
    }
    
    func withdraw(_ amount: Double, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        completion(.success(TransactionResult(transactionId: UUID().uuidString,
                                              transactionType: "withdraw",
                                              amount: amount,
                                              currency: "thb",
                                              status: true,
                                              message: "Withdraw successfully",
                                              error: nil,
                                              createdAt: Date(),
                                              updatedAt: Date(),
                                              expiration: nil,
                                              metadata: nil,
                                              provider: "Kbank")))
    }
    
    func cancelTransaction(_ transactionID: String, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "cancel transactionID: \(transactionID) failed!"])))
    }
}
