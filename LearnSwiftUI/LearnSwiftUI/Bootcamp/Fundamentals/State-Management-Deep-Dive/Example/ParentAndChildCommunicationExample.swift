//
//  ParentAndChildCommunicationExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/2/26.
//

import SwiftUI

struct ParentAndChildCommunicationExample: View {
    @State private var username = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(username)")
            UsernameInputExample(username: $username)
        }
    }
}

struct UsernameInputExample: View {
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username)
    }
}
