//
//  OptionalViewExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

struct OptionalViewExample: View {
    let title: String?
    
    var body: some View {
        if let unwrapTitle = title {
            Text(unwrapTitle)
        }
        
        title.map { title in
            Text(title)
        }
    }
}

#Preview {
    OptionalViewExample(title: "Hello Swift")
}
