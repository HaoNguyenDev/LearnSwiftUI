//
//  FocusStateBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 17/8/25.
//

import SwiftUI

struct FocusStateBootcamp: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @FocusState private var focusedField: Field?
    @FocusState private var isTextFieldFocused: Bool // Use when we have only one field need to check
    
    enum Field: Hashable {
        case username
        case password
    }
    
    var body: some View {
        VStack {
            Text("Focus State")
                .font(.largeTitle)
                
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                                    .focused($focusedField, equals: .username)
                                    .focused($isTextFieldFocused)
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(focusedField == .username ? .blue : .clear),
                                        alignment: .bottom
                                    )
                            
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                                    .focused($focusedField, equals: .password)
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(focusedField == .password ? .blue : .clear),
                                        alignment: .bottom
                                    )
            }
            .padding()
            
            Button("Login") {
                focusedField = nil
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear() {
            focusedField = .username
            print("Focused Field: \(focusedField == .username)")
        }
    }
}

#Preview {
    FocusStateBootcamp()
}
