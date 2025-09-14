//
//  PaymentService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//


// Protocol Definition (Abstraction According to DIP and ISP)
import Foundation

protocol PaymentServiceProtocol {
    func deposit(_ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void)
    func transfer(_ toRecipient: String,_ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void)
    func withdraw(_ amount: Double, completion: @escaping (Result<TransactionResult, Error>) -> Void)
    func cancelTransaction(_ transactionID: String, completion: @escaping (Result<TransactionResult, Error>) -> Void)
}
