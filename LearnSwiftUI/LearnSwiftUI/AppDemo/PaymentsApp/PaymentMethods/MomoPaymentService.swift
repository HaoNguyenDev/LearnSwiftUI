//
//  MomoPaymentService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//

// Mock Momo SDK
class MomoSDK {
    static let shared = MomoSDK()
    
    func deposit(amount: NSDecimalNumber, completion: @escaping (String?, Error?) -> Void) {
        completion("123456789", nil)
    }
    
    func transfer(toRecipient: String, amount: NSDecimalNumber, completion: @escaping (String?, Error?) -> Void) {
        completion("987654321", nil)
    }
    
    func withdraw(amount: NSDecimalNumber, completion: @escaping (String?, Error?) -> Void) {
        completion("456123789", nil)
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
    
    func deposit(amount: Decimal, completion: @escaping (Result<String, Error>) -> Void) {
        // Call Momo deposit API/SDK
        momoSDK.deposit(amount: NSDecimalNumber(decimal: amount)) { transactionID, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(transactionID ?? ""))
            }
        }
    }
    
    func transfer(toRecipient: String, amount: Decimal, completion: @escaping (Result<String, Error>) -> Void) {
        momoSDK.transfer(toRecipient: toRecipient, amount: NSDecimalNumber(decimal: amount)) { transactionID, error in
            // Handle completion
        }
    }
    
    func withdraw(amount: Decimal, completion: @escaping (Result<String, Error>) -> Void) {
        momoSDK.withdraw(amount: NSDecimalNumber(decimal: amount)) { transactionID, error in
            // Handle completion
        }
    }
    
    func cancelTransaction(_ transactionID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        momoSDK.cancelTransaction(transactionID) { success, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(success))
            }
        }
    }
}
