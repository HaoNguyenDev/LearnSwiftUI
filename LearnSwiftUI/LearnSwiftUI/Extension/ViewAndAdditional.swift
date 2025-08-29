//
//  ViewAndAdditional.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/8/25.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
