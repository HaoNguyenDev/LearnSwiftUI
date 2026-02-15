//
//  MyBinding.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

@propertyWrapper
struct MyBinding<Value> {
    var wrappedValue: Value {
        get { getter() }
        nonmutating set { setter(newValue) }
    }
    
    private let getter: () -> Value
    private let setter: (Value) -> Void
    
    init(get: @escaping () -> Value, set: @escaping (Value) -> Void) {
        self.getter = get
        self.setter = set
    }
}
