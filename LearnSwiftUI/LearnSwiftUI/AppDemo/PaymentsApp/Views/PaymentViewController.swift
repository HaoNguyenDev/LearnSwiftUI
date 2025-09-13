//
//  PaymentViewController.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//

@Observable class PaymentVM {
    
    var result: String?
    var error: Error?
    
    private let paymentService: PaymentService
    
    init(paymentService: PaymentService) {
        self.paymentService = paymentService
    }
    
    func deposit(amount: Double) async throws {
        paymentService.deposit(amount) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let txID):
                self.result = "Deposit success with \(txID)"
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func transfer(toRecipient: String, amount: Double) async throws {
        paymentService.transfer(toRecipient, amount) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.result = result.message
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func withdraw(amount: Double) async throws {
        paymentService.withdraw(amount) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.result = result.message
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func cancelTransaction(transactionID: String) async throws {
        paymentService.cancelTransaction(transactionID) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let state):
                self.result = "Canceled transactionID: \(transactionID) with state: \(state)"
            case .failure(let error):
                self.error = error
            }
        }
    }
}


import SwiftUI

struct PaymentView: View {
    
    private var result: String?
    
    var body: some View {
        VStack {
           
            Button {
                
            } label: {
                Text("Deposit")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                
            } label: {
                Text("Transfer")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                
            } label: {
                Text("Withdraw")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                
            } label: {
                Text("Cancel Transaction")
            }
            .buttonStyle(.borderedProminent)
            
            Text("Payment result info")
            Text(result ?? "")
        }
    }
}

#Preview {
    NavigationStack {
        PaymentView()
            .navigationBarTitle("Payment View")
    }
}
