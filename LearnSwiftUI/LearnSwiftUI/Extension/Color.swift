//
//  Color.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import Foundation
import SwiftUI
import UIKit

extension Color {
    static let customTextColor = Color("CustomTextColor")
    static let customBackgroundColor = Color("CustomBackgroundColor")
}


extension Color {
    static func hexColor(_ hexString: String) -> Color {
        Color(uiColor: UIColor.hexColor(hexString))
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

public extension UIColor {
    static func hexColor(_ hexString: String, alpha: CGFloat? = 1.0) -> UIColor {
        let r, g, b, a: CGFloat
        var hex = hexString
        if !hexString.hasPrefix("#") {
            hex = "#" + hexString
        }
        
        let start = hex.index(hexString.startIndex, offsetBy: 1)
        var hexColor = String(hex[start...])
        
        if hexColor.count == 6 {
            hexColor += "FF"
        }
        
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                
                return UIColor.init(red: r, green: g, blue: b, alpha: a)
            }
        }
        return UIColor.init(red: 1, green: 0, blue: 0, alpha: 1.0)
    }
    
    var hexString: String {
            let cgColorInRGB = cgColor.converted(to: CGColorSpace(name: CGColorSpace.sRGB)!, intent: .defaultIntent, options: nil)!
            let colorRef = cgColorInRGB.components
            let r = colorRef?[0] ?? 0
            let g = colorRef?[1] ?? 0
            let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
            let a = cgColor.alpha

            var color = String(
                format: "#%02lX%02lX%02lX",
                lroundf(Float(r * 255)),
                lroundf(Float(g * 255)),
                lroundf(Float(b * 255))
            )

            if a < 1 {
                color += String(format: "%02lX", lroundf(Float(a * 255)))
            }

            return color
        }
}
