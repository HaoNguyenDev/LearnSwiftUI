//
//  ActorBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/10/25.
//

import SwiftUI

actor BankAccount {
    private var balance: Double = 0
    
    func deposit(_ amount: Double) {
        balance += amount
    }
    
    func withdraw(_ amount: Double) -> Bool {
        if balance >= amount {
            balance -= amount
            return true
        }
        return false
    }
    
    func getBalance() -> Double {
        return balance
    }
}

fileprivate enum BankAccountError: Error, LocalizedError {
    case insufficientBalance
    
    var errorDescription: String? {
        switch self {
        case .insufficientBalance:
            return "Insufficient balance"
        }
    }
}

@MainActor
fileprivate class BankAccountViewModel: ObservableObject {
    private let bankAccount: BankAccount
    @Published var currentBalance: Double = 0.0
    @Published var error: Error?
    
    init(bankAccount: BankAccount) {
        self.bankAccount = bankAccount
        Task {
            await refreshBalance()
        }
    }
    
    func refreshBalance() async {
        currentBalance = await bankAccount.getBalance()
    }
    
    func deposit(_ amount: Double) async {
        await bankAccount.deposit(amount)
        await refreshBalance()
    }
    
    func withdraw(_ amount: Double) async {
        let result = await bankAccount.withdraw(amount)
        if !result {
            error = BankAccountError.insufficientBalance
        }
        await refreshBalance()
    }
}

struct BankAccountView: View {
    @StateObject private var viewModel: BankAccountViewModel
    @State private var inputAmount: String = ""
    
    init() {
        _viewModel = StateObject(wrappedValue:  BankAccountViewModel(bankAccount: BankAccount()))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current Balance: $\(viewModel.currentBalance, specifier: "%.2f")")
                .font(.title)
            
            if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)").foregroundColor(.red)
            }
            
            Divider()
            
            VStack {
                TextField("Amount", text: $inputAmount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                
                Button("Deposit") {
                    if let amount = Double(inputAmount) {
                        deposit(amount)
                        inputAmount = ""
                    }
                }
                .buttonStyle(.primaryHButton)
                .disabled(!isEnabledDeposit())
                
                Button("Withdraw") {
                    guard let amount = Double(inputAmount) else { return }
                    withdraw(amount)
                }
                .buttonStyle(.primaryHButton)
                .disabled(!isEnabledWithdraw())
            }
        }
        .padding()
    }
}

extension BankAccountView {
    private func deposit(_ amount: Double) {
        Task {
            await viewModel.deposit(amount)
        }
    }
    
    private func withdraw(_ amount: Double) {
        Task {
            await viewModel.withdraw(amount)
            inputAmount = ""
        }
    }
    
    private func isEnabledDeposit() -> Bool {
        Double(inputAmount) ?? 0 > 0
    }
    
    private func isEnabledWithdraw() -> Bool {
        Double(inputAmount) ?? 0 > 0 // && viewModel.currentBalance >= Double(inputAmount) ?? 0
    }
}

#Preview {
    BankAccountView()
}
