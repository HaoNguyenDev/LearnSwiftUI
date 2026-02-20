//
//  Validator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

// MARK: - Validator

enum Validator {
    static func email(_ value: String) -> String? {
        guard !value.isEmpty else { return "The email address cannot be left blank" }
        let regex = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        guard value.range(of: regex, options: .regularExpression) != nil else {
            return "Email is not in the correct format."
        }
        return nil
    }
    
    static func password(_ value: String) -> String? {
        guard !value.isEmpty else { return "The password cannot be left blank." }
        guard value.count >= 8 else {
            let remaining = 8 - value.count
            return "Missing \(remaining) characters (at least 8)"
        }
        guard value.range(of: #"[A-Z]"#, options: .regularExpression) != nil else {
            return "At least one capital letter is required"
        }
        guard value.range(of: #"[0-9]"#, options: .regularExpression) != nil else {
            return "At least one digit is required"
        }
        return nil
    }
    
    static func passwordStrength(_ value: String) -> PasswordStrength {
        var score = 0
        if value.count >= 8 { score += 1 }
        if value.range(of: #"[A-Z]"#, options: .regularExpression) != nil { score += 1 }
        if value.range(of: #"[0-9]"#, options: .regularExpression) != nil { score += 1 }
        if value.range(of: #"[^A-Za-z0-9]"#, options: .regularExpression) != nil { score += 1 }
        return PasswordStrength(rawScore: score)
    }
}
