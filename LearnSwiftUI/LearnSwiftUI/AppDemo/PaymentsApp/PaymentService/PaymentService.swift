//
//  PaymentService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//


// Protocol Definition (Abstraction According to DIP and ISP)
import Foundation

protocol PaymentService {
    func deposit(amount: Decimal, completion: @escaping (Result<String, Error>) -> Void)
    func transfer(toRecipient: String, amount: Decimal, completion: @escaping (Result<String, Error>) -> Void)
    func withdraw(amount: Decimal, completion: @escaping (Result<String, Error>) -> Void)
    func cancelTransaction(_ transactionID: String, completion: @escaping (Result<Bool, Error>) -> Void)
}
