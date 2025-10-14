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
