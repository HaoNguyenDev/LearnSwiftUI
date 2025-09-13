//
//  PaymentViewController.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//

import UIKit

class PaymentViewController: UIViewController {
    private var paymentService: PaymentService!
    
    let depositButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Deposit", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let countryCode = getCurrentCountryCode() // Or LocationManager.shared.countryCode
        self.paymentService = PaymentFactory.createPaymentService(for: countryCode)
        
        depositButton.addTarget(self, action: #selector(depositTapped), for: .touchUpInside)
    }
    
    @objc private func depositTapped() {
        paymentService.deposit(amount: 100.0) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let txID):
                    print("Deposit success: \(txID)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    // The same with transfer and withdraw method
}
