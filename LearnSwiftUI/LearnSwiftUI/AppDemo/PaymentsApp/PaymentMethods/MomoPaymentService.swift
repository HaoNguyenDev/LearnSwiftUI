//
//  MomoPaymentService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//

// Mock Momo SDK
class MomoSDK {
    static let shared = MomoSDK()
    
    func deposit(amount: Double, completion: @escaping (String?, Error?) -> Void) {
        completion("Deposit successfully", nil)
    }
    
    func transfer(toRecipient: String, amount: Double, completion: @escaping (String?, Error?) -> Void) {
        completion("Transfer successfully", nil)
    }
    
    func withdraw(amount: Double, completion: @escaping (String?, Error?) -> Void) {
        completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Withdrawal failed"]))
    }
    
    func cancelTransaction(_ transactionID: String, completion: @escaping (Bool, Error?) -> Void) {
        completion(true, nil)
    }
}

// import MomoSDK
import Foundation

class MomoPaymentService: PaymentService {
    private let momoSDK: MomoSDK // Inject dependency if need
    
    init() {
        self.momoSDK = MomoSDK.shared
    }
    
    func deposit(_ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void) {
        // Call Momo deposit API/SDK
        momoSDK.deposit(amount: amount) { message, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(TransactionResult(transactionId: UUID().uuidString,
                                                      transactionType: "deposit",
                                                      amount: amount,
                                                      currency: "VND",
                                                      status: true,
                                                      message: message,
                                                      error: nil,
                                                      createdAt: Date(),
                                                      updatedAt: Date(),
                                                      expiration: nil,
                                                      metadata: nil)))
            }
        }
    }
    
    func transfer(_ toRecipient: String, _ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void) {
        momoSDK.transfer(toRecipient: toRecipient, amount: amount) { transactionID, error in
            // Handle completion
        }
    }
    
    func withdraw(_ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void) {
        momoSDK.withdraw(amount: amount) { transactionID, error in
            // Handle completion
        }
    }
    
    func cancelTransaction(_ transactionID: String, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        momoSDK.cancelTransaction(transactionID) { success, error in
            // Handle completion
        }
    }
}
