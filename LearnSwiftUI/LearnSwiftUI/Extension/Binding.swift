//
//  Binding.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

extension Binding {
    init?(_ binding: Binding<Value?>) {
        guard let value = binding.wrappedValue else {
            return nil
        }
        self.init(
            get: { binding.wrappedValue ?? value },
            set: { binding.wrappedValue = $0 }
        )
    }
}
