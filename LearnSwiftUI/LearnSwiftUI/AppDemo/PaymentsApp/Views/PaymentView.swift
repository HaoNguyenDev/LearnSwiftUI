//
//  PaymentView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//

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
            
            
            
            if vm.error != nil, let transactionError = vm.error as? TransactionError {
                let errorMessage = transactionError.localizedDescription
                Text("Error info: \(errorMessage)")
            } else {
                Text(vm.result ?? "")
            }
            
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
