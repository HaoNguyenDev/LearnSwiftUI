//
//  ThaiPaymentService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//
import Foundation

class ThaiPaymentService: PaymentService {
    private let baseURL = URL(string: "https://api.thai-payment.com")!
    
    func deposit(amount: Decimal, completion: @escaping (Result<String, Error>) -> Void) {
        // call network service with thailand payment url
    }
    
    func transfer(toRecipient: String, amount: Decimal, completion: @escaping (Result<String, any Error>) -> Void) {
        
    }
    
    func withdraw(amount: Decimal, completion: @escaping (Result<String, any Error>) -> Void) {
        
    }
    
    func cancelTransaction(_ transactionID: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        
    }
}
