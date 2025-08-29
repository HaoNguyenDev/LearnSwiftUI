//
//  TextFieldBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/8/25.
//

import SwiftUI

struct TextFieldBootcamp: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var phonenumber = ""
    
    @FocusState private var focusedField: FocusField?
    
    enum FocusField {
        case username, email, password, phonenumber
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter your name", text: $username)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .username)
                    .submitLabel(SubmitLabel.next)
                    .onSubmit {
                        focusedField = .email
                    }
                
                TextField("Enter your email", text: $email)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)
                    .submitLabel(SubmitLabel.next)
                    .onSubmit {
                        focusedField = .password
                    }
                
                SecureField("Enter your password", text: $password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(SubmitLabel.next)
                    .onSubmit {
                        focusedField = .phonenumber
                    }
                
                TextField("Enter your phone number", text: $phonenumber)
                    .keyboardType(.phonePad)
                    .focused($focusedField, equals: .phonenumber)
                    .submitLabel(SubmitLabel.next)
                    .onSubmit {
                        focusedField = .phonenumber
                    }
            }
            .navigationTitle(Text("TextField Bootcamp"))
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

#Preview {
    TextFieldBootcamp()
        .preferredColorScheme(.dark)
}
