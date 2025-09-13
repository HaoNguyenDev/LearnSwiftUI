//
//  ThaiPaymentService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//
import Foundation

class ThaiPaymentService: PaymentService {
    private let baseURL = URL(string: "https://api.thai-payment.com")!
    
    func deposit(_ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void) {
        // call network service with thailand payment url
    }
    
    func transfer(_ toRecipient: String, _ amount: Double, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        
    }
    
    func withdraw(_ amount: Double, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        
    }
    
    func cancelTransaction(_ transactionID: String, completion: @escaping (Result<TransactionResult, any Error>) -> Void) {
        
    }
}
