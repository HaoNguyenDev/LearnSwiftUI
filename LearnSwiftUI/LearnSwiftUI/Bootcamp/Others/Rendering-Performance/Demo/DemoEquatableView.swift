//
//  DemoEquatableView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 24/1/26.
//

import SwiftUI

struct DemoEquatableView: View, Equatable {
    let stringData: String
    
    var body: some View {
        Text(stringData)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.stringData == rhs.stringData
    }
}

struct UseDemoEquatableView: View {
    var body: some View {
        DemoEquatableView(stringData: "Hello SwiftUI!")
            .equatable()
    }
}
