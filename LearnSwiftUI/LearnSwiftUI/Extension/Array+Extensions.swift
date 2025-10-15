//
//  Array+Extensions.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/10/25.
//

import Foundation

// MARK: - Safe access array
extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
