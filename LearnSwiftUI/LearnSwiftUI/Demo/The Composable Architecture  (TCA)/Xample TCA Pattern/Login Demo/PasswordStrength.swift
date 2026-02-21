//
//  PasswordStrength.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import SwiftUI

struct PasswordStrength {
    let rawScore: Int  // 0–4
    
    var level: Int { min(rawScore, 4) }
    
    var label: String {
        switch level {
        case 1: return "Weak"
        case 2: return "Average"
        case 3: return "Quite strong"
        case 4: return "Strong"
        default: return ""
        }
    }
    
    var color: Color {
        switch level {
        case 1: return Color(hex: "E05252")
        case 2: return Color(hex: "E8974A")
        case 3: return Color(hex: "5BAD7A")
        case 4: return Color(hex: "2E7D52")
        default: return Color.gray.opacity(0.3)
        }
    }
}
