//
//  String+Extensions.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/10/25.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

extension String {
    var doubleValue: Double? {
        let formatter = NumberFormatter()
        if let number = formatter.number(from: self) {
            return number.doubleValue
        }
        formatter.locale = Locale(identifier: "en_US")
        if let number = formatter.number(from: self) {
            return number.doubleValue
        }
        
        formatter.locale = Locale(identifier: "vi_VN")
        if let number = formatter.number(from: self) {
            return number.doubleValue
        }
        return nil
    }
}
