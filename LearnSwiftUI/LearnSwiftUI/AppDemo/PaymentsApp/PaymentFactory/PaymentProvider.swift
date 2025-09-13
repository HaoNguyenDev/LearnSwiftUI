//
//  PaymentProvider.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//

/*
 Factory Pattern for Creating Instances (OCP and DIP)
 Create a PaymentFactory that returns the correct implementation based on the country code. This keeps the main code (e.g. ViewController) dependent on the protocol, not the concrete class.
 */

enum PaymentProvider {
    case momo, thaiAPI, payPal, unknown
}

class PaymentFactory {
    static func createPaymentService(for countryCode: String) -> PaymentService {
        switch countryCode.uppercased() {
        case "VN":
            return MomoPaymentService()
        case "TH":
            return ThaiPaymentService()
        case "US", "GB": // PayPal for other country
            return PayPalPaymentService()
        default:
            return PayPalPaymentService() // Fallback
        }
    }
}
