//
//  TextFieldBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/8/25.
//

import SwiftUI
import Combine

class TextViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var textString = ""
    @Published var isEnableButton = false
    
    init() {
       binding()
    }
    
    private func binding() {
        $textString
            .map({ text in
                return text.isEmpty
            })
            .sink { [weak self] bool in
                self?.isEnableButton = bool
            }.store(in: &cancellables)
    }
}

struct TextFieldBootcamp: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var phonenumber = ""
    
    @FocusState private var focusedField: FocusField?
    
    @StateObject private var vm = TextViewModel()
    
    enum FocusField {
        case username, email, password, phonenumber
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack(spacing: 0) {
                    TextField("Enter your name", text: $vm.textString)
                        .defaultTf()
                        .textInputAutocapitalization(.never)
                        .focused($focusedField, equals: .username)
                        .submitLabel(SubmitLabel.next)
                        .onSubmit {
                            focusedField = .email
                        }
                    
                    Button {
                        
                    } label: {
                        Text("Type to enable this button")
                    }
    //                .buttonStyle(HButtonStyle(size: .large, type: .primary))
                    .buttonStyle(.primaryHButton)
                    .padding(.horizontal)
                    .padding(.top)
                    .disabled(vm.isEnableButton)
                }
                
                
                TextField("Enter your email", text: $email)
                    .defaultTf()
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)
                    .submitLabel(SubmitLabel.next)
                    .onSubmit {
                        focusedField = .password
                    }
                
                SecureField("Enter your password", text: $password)
                    .defaultTf()
                    .focused($focusedField, equals: .password)
                    .submitLabel(SubmitLabel.next)
                    .onSubmit {
                        focusedField = .phonenumber
                    }
                
                TextField("Enter your phone number", text: $phonenumber)
                    .defaultTf()
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
        .preferredColorScheme(.light)
}
