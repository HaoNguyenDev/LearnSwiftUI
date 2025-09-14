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
    private static var cachePaymentService: [String: PaymentServiceProtocol] = [:]
    private init() {}
    static func createPaymentService(for countryCode: String) -> PaymentServiceProtocol {
        if let existingPaymentService = PaymentFactory.cachePaymentService[countryCode] {
            return existingPaymentService
        } else {
            switch countryCode.uppercased() {
            case "VN":
                cachePaymentService["VN"] = MomoPaymentService()
                return MomoPaymentService()
            case "TH":
                cachePaymentService["TH"] = ThaiPaymentService()
                return ThaiPaymentService()
            case "US", "GB": // Visa for other country
                cachePaymentService["US"] = VisaPaymentService()
                cachePaymentService["GB"] = VisaPaymentService()
                return VisaPaymentService()
            default:
                return VisaPaymentService() // Fallback
            }
        }
       
    }
}
