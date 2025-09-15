//
//  PaymentVM.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/9/25.
//
import SwiftUIg

@Observable class PaymentVM {
    
    var result: String?
    var error: Error?
    
    private let paymentService: PaymentServiceProtocol
    
    init(paymentService: PaymentServiceProtocol) {
        self.paymentService = paymentService
    }
    
    func deposit(amount: Double) {
        paymentService.deposit(amount) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.result = "Deposit success with \(result)"
                self.error = nil
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func transfer(toRecipient: String, amount: Double) {
        paymentService.transfer(toRecipient, amount) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.result = result.message
                self.error = nil
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func withdraw(amount: Double) {
        paymentService.withdraw(amount) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.result = result.message
                self.error = nil
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func cancelTransaction(transactionID: String) {
        paymentService.cancelTransaction(transactionID) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let state):
                self.result = "Canceled transactionID: \(transactionID) with state: \(state)"
                self.error = nil
            case .failure(let error):
                self.error = error
            }
        }
    }
}
