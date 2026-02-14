//
//  ActorBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/10/25.
//

import SwiftUI

// MARK: - 1. Data Structure and Actor

// Wallet struct (value type)
struct Wallet: Identifiable, Hashable {
    let id: String // Used as key and Identifiable
    var name: String
    var balance: Double
}

// Custom errors using async throws instead of Result
fileprivate enum BankAccountError: Error, LocalizedError {
    case insufficientBalance
    case sourceWalletNotFound
    case destinationWalletNotFound
    case sameSourceAndDestination
    
    var errorDescription: String? {
        switch self {
        case .insufficientBalance: return "Insufficient balance for the transaction."
        case .sourceWalletNotFound: return "Source wallet not found."
        case .destinationWalletNotFound: return "Destination wallet not found."
        case .sameSourceAndDestination: return "Cannot transfer money between the same two wallets."
        }
    }
}

// BankAccount (Actor) manages multiple Wallets
actor BankAccount {
    // Dictionary to manage multiple Wallets by ID (isolated state)
    private var wallets: [String: Wallet]
    
    init(wallets: [Wallet]) {
        // Initialize the dictionary from the array
        self.wallets = Dictionary(uniqueKeysWithValues: wallets.map { ($0.id, $0) })
    }
    
    // Get a copy of all Wallets (safe read-only access)
    func getAllWallets() -> [Wallet] {
        return Array(wallets.values)
    }
    
    // Get a specific Wallet
    func getWallet(id: String) -> Wallet? {
        return wallets[id]
    }
    
    // Deposit into a specific Wallet
    func deposit(to walletID: String, amount: Double) {
        wallets[walletID]?.balance += amount
    }
    
    // Withdraw from a specific Wallet
    func withdraw(from walletID: String, amount: Double) -> Bool {
        guard let wallet = wallets[walletID], wallet.balance >= amount else {
            return false
        }
        wallets[walletID]?.balance -= amount
        return true
    }
    
    // Transfer method using async throws (no Result)
    func transfer(from sourceID: String, to destinationID: String, amount: Double) async throws {
        guard sourceID != destinationID else {
            throw BankAccountError.sameSourceAndDestination
        }
        guard wallets[sourceID] != nil else {
            throw BankAccountError.sourceWalletNotFound
        }
        guard wallets[destinationID] != nil else {
            throw BankAccountError.destinationWalletNotFound
        }
        
        // Attempt to withdraw first
        if withdraw(from: sourceID, amount: amount) {
            // If successful, proceed with deposit
            deposit(to: destinationID, amount: amount)
        } else {
            throw BankAccountError.insufficientBalance
        }
    }
}

// MARK: - 2. BankAccountViewModel (MainActor)

@MainActor
final class BankAccountViewModel: ObservableObject {
    private let bankAccount: BankAccount
    
    @Published var allWallets: [Wallet] = []
    @Published var selectedSourceWalletID: String? // Currently selected source wallet ID
    @Published var selectedDestinationWalletID: String? // Currently selected destination wallet ID
    @Published var currentBalance: Double = 0.0 // Balance of the selected source wallet
    @Published var error: Error?
    
    init(bankAccount: BankAccount) {
        self.bankAccount = bankAccount
        Task {
            await initializeWallets()
        }
    }
    
    private func initializeWallets() async {
        allWallets = await bankAccount.getAllWallets()
        selectedSourceWalletID = allWallets.first?.id // Set first wallet as default source
        // Set a different wallet as default destination if available
        selectedDestinationWalletID = allWallets.last(where: { $0.id != selectedSourceWalletID })?.id
        await refreshBalance()
    }
    
    func refreshBalance() async {
        // Update the list of all wallets for the Picker
        allWallets = await bankAccount.getAllWallets()
        
        // Update the balance of the currently selected source wallet
        if let sourceID = selectedSourceWalletID, let wallet = await bankAccount.getWallet(id: sourceID) {
            currentBalance = wallet.balance
        } else {
            currentBalance = 0.0
        }
    }
    
    // Called when the user changes the source wallet
    func didSelectSourceWallet(id: String) async {
        selectedSourceWalletID = id
        await refreshBalance()
    }
    
    // MARK: - Account Operations
    
    func deposit(_ amount: Double) async {
        clearError()
        guard let sourceID = selectedSourceWalletID else {
            error = BankAccountError.sourceWalletNotFound
            return
        }
        await bankAccount.deposit(to: sourceID, amount: amount)
        await refreshBalance()
    }
    
    func withdraw(_ amount: Double) async {
        clearError()
        guard let sourceID = selectedSourceWalletID else {
            error = BankAccountError.sourceWalletNotFound
            return
        }
        let result = await bankAccount.withdraw(from: sourceID, amount: amount)
        if !result {
            error = BankAccountError.insufficientBalance
        }
        await refreshBalance()
    }
    
    // Transfer method using async throws
    func transfer(amount: Double) async {
        clearError()
        guard let sourceID = selectedSourceWalletID, let destinationID = selectedDestinationWalletID else {
            error = BankAccountError.sourceWalletNotFound // Or similar error
            return
        }
        
        do {
            try await bankAccount.transfer(from: sourceID, to: destinationID, amount: amount)
            // If successful, refresh balance
            await refreshBalance()
        } catch let transferError {
            // If failed, set the error to display in the View
            error = transferError
        }
    }
    
    private func clearError() {
        error = nil
    }
}

// MARK: - 3. SwiftUI View

struct BankAccountView: View {
    // StateObject manages the ViewModel's lifecycle
    @StateObject private var viewModel: BankAccountViewModel
    @State private var inputAmount: String = ""
    @State private var transferAmount: String = ""
    @State private var isTransferMode = false // Toggle between Deposit/Withdraw and Transfer
    
    init() {
        // Initialize multiple Wallets and the Actor
        let wallets = [
            Wallet(id: "main", name: "Main Wallet", balance: 1000.00),
            Wallet(id: "saving", name: "Savings Wallet", balance: 500.00),
            Wallet(id: "travel", name: "Travel Fund", balance: 50.00)
        ]
        let bankAccount = BankAccount(wallets: wallets)
        
        // Initialize @StateObject manually in init()
        _viewModel = StateObject(wrappedValue: BankAccountViewModel(bankAccount: bankAccount))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Source Wallet Picker
            walletPicker(selection: $viewModel.selectedSourceWalletID, label: "Source Wallet")
                .onChange(of: viewModel.selectedSourceWalletID) { _, newID in
                    guard let newID else { return }
                    Task {
                        await viewModel.didSelectSourceWallet(id: newID)
                    }
                }
            
            Text("Balance: $\(viewModel.currentBalance, specifier: "%.2f")")
                .font(.title).bold()
            
            // Error display
            if let error = viewModel.error {
                Text("Error: \((error as? LocalizedError)?.errorDescription ?? error.localizedDescription)")
                    .foregroundColor(.red)
            }
            
            // Mode Segmented Picker
            Picker("Mode", selection: $isTransferMode) {
                Text("Deposit/Withdraw").tag(false)
                Text("Transfer").tag(true)
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 10)
            
            Divider()
            
            if isTransferMode {
                TransferSection // Transfer interface
            } else {
                DepositWithdrawSection // Deposit/Withdraw interface
            }
        }
        .padding()
    }
    
    // MARK: - View Components
    
    var DepositWithdrawSection: some View {
        VStack {
            HTextField(title: "",
                       placeholder: "Enter amount",
                       keyboardType: .numberPad,
                       leftImage: nil,
                       text: $inputAmount)
            
            Button("Deposit") {
                if let amount = Double(inputAmount), amount > 0 {
                    Task { await viewModel.deposit(amount) }
                    inputAmount = ""
                }
            }
            .buttonStyle(.primaryHButton)
            .disabled(inputAmount.doubleValue ?? 0 <= 0)
            
            Button("Withdraw") {
                if let amount = Double(inputAmount), amount > 0 {
                    Task { await viewModel.withdraw(amount) }
                    inputAmount = ""
                }
            }
            .buttonStyle(.primaryHButton)
            .disabled(inputAmount.doubleValue ?? 0 <= 0)
        }
    }
    
    var TransferSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // Destination Wallet Picker
            walletPicker(selection: $viewModel.selectedDestinationWalletID, label: "Destination Wallet")
                .padding(.bottom, 5)

            VStack {
                HTextField(title: "",
                           placeholder: "Enter amount",
                           keyboardType: .numberPad,
                           leftImage: nil,
                           text: $transferAmount)
                
                Button("Transfer") {
                    if let amount = Double(transferAmount), amount > 0 {
                        Task { await viewModel.transfer(amount: amount) } // Call async throws function
                        inputAmount = ""
                    }
                }
                .buttonStyle(.primaryHButton)
                .disabled(transferAmount.doubleValue ?? 0 <= 0)
//                .disabled(viewModel.selectedSourceWalletID == viewModel.selectedDestinationWalletID)
            }
        }
    }
    
    // Reusable Wallet Picker View
    @ViewBuilder
    private func walletPicker(selection: Binding<String?>, label: String) -> some View {
        HStack {
            Text(label + ":")
            Picker(label, selection: selection) {
                // Display all available wallets in the picker
                ForEach(viewModel.allWallets) { wallet in
                    Text("\(wallet.name) \(wallet.balance.formattedAsTwoDecimals)")
                        .tag(Optional(wallet.id)) // Use Optional(id) for Binding<String?>
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    BankAccountView()
}
