//
//  PayPalPaymentService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//

import Foundation

class VisaSDK {
    static var shared: VisaSDK!
    
    func deposit(_ amount: Double, completion: @escaping (Result<String, Error>) -> Void) {
        Thread.sleep(forTimeInterval: 1)
        completion(.success("Deposit successful for \(amount)!"))
    }
    
    // Transfer
    func transfer(_ amount: Double, to recipient: String, completion: @escaping (Result<String, Error>) -> Void) {
        Thread.sleep(forTimeInterval: 1)
        completion(.success("Transfer successful for \(amount) to \(recipient)!"))
    }
    
    // Withdraw
    func withdraw(_ amount: Double, completion: @escaping (Result<String, Error>) -> Void) {
        Thread.sleep(forTimeInterval: 1)
        completion(.success("Withdrawal successful for \(amount)!"))
    }
    
    // Cancel transaction
    func cancelTransaction(_ transactionId: String, completion: @escaping (Result<String, Error>) -> Void) {
        Thread.sleep(forTimeInterval: 1)
        completion(.success("Transaction \(transactionId) cancelled!"))
    }
}

class VisaPaymentService: PaymentServiceProtocol {
    // Integrate Visa SDK
    private let visaSDK: VisaSDK
    
    init() {
        self.visaSDK = VisaSDK.shared
    }
    
    func deposit(_ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void) {
        // call Visa deposit flow
        visaSDK.deposit(amount) { result in
            switch result {
            case .success(let msg):
                completion(.success(TransactionResult(transactionId: UUID().uuidString,
                                                      transactionType: "deposit",
                                                      amount: amount,
                                                      currency: "USD",
                                                      status: true,
                                                      message: msg,
                                                      error: nil,
                                                      createdAt: Date(),
                                                      updatedAt: Date(),
                                                      expiration: nil,
                                                      metadata: nil,
                                                      provider: "Visa")))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func transfer(_ toRecipient: String, _ amount: Double, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        visaSDK.transfer(amount, to: toRecipient) { result in
            switch result {
            case .success(let msg):
                completion(.success(TransactionResult(transactionId: UUID().uuidString,
                                                      transactionType: "transfer",
                                                      amount: amount,
                                                      currency: "USD",
                                                      status: true,
                                                      message: msg,
                                                      error: nil,
                                                      createdAt: Date(),
                                                      updatedAt: Date(),
                                                      expiration: nil,
                                                      metadata: nil,
                                                      provider: "Visa")))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func withdraw(_ amount: Double, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        let transactionResult = TransactionResult(transactionId: UUID().uuidString,
                                                  transactionType: "withdraw",
                                                  amount: amount,
                                                  currency: "USD",
                                                  status: true,
                                                  message: "Withdrawal successful for \(amount) USD!",
                                                  error: nil,
                                                  createdAt: Date(),
                                                  updatedAt: nil,
                                                  expiration: nil,
                                                  metadata: nil,
                                                  provider: "Visa")
        completion(.success(transactionResult))
    }
    
    func cancelTransaction(_ transactionID: String, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Transaction cancellation for \(transactionID) failed!"])))
    }
}
