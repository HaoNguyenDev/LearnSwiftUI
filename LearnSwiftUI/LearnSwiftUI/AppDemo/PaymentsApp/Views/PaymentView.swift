//
//  PaymentView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//

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
            case .failure(let error):
                self.error = error
            }
        }
    }
}


import SwiftUI

struct PaymentView: View {
    @State private var vm: PaymentVM
    @State private var amountString: String = ""
    private var result: String?
    
    init(vm: PaymentVM) {
        self._vm = State(initialValue: vm)
    }
    
    var body: some View {
        VStack {
           
            TextField("Enter amount", text: $amountString)
            
            // MARK: Deposit
            Button {
                deposit(amount: amountString)
                
            } label: {
                Text("Deposit")
            }
            .buttonStyle(.borderedProminent)
            
            // MARK: Transfer
            Button {
                transfer(amount: amountString)
            } label: {
                Text("Transfer")
            }
            .buttonStyle(.borderedProminent)
            
            // MARK: Witdrawal
            Button {
                withdraw(amount: amountString)
            } label: {
                Text("Withdraw")
            }
            .buttonStyle(.borderedProminent)
            
            // MARK: Cancel Transaction
            Button {
                cancelTransaction()
            } label: {
                Text("Cancel Transaction")
            }
            .buttonStyle(.borderedProminent)
            
            Text("Payment result info")
            Text(vm.result ?? "")
        }
        .padding()
    }
    
    private func deposit(amount: String) {
        vm.deposit(amount: Double(amount) ?? 0.0)
    }
    
    private func transfer(amount: String) {
        vm.transfer(toRecipient: "+1234567890", amount: Double(amount) ?? 0.0)
    }
    
    private func withdraw(amount: String) {
        vm.withdraw(amount: Double(amount) ?? 0.0)
    }
    
    private func cancelTransaction() {
        vm.cancelTransaction(transactionID: "12345")
    }
}

#Preview {
    let countryCode = getCurrentCountryCode()
    let paymentService = PaymentFactory.createPaymentService(for: countryCode)
    NavigationStack {
        PaymentView(vm: PaymentVM(paymentService: paymentService))
            .navigationBarTitle("Payment View")
    }
}
