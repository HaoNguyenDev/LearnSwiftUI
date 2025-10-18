//
//  Double+Extensions.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/10/25.
//

import Foundation

extension Double {
    /// Formats a Double number as a string with 2 fixed decimal places.
    /// Example: 12.345 -> "12.35", 12.0 -> "12.00"
    var formattedAsTwoDecimals: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2 // Ensure there is always at least 2 decimal places
        formatter.maximumFractionDigits = 2 // Limit to a maximum of 2 decimal places (will round)
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    func formatted(toDecimals decimals: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = decimals
        formatter.maximumFractionDigits = decimals
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
