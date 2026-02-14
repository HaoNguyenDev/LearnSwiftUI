//
//  LoginView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

struct LoginViewSafeAreaInset: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()   // ✅ chỉ background

            ScrollView {
                VStack(spacing: 20) {
                    Spacer().frame(height: 80)

                    Text("Login")
                        .font(.largeTitle)
                        .foregroundColor(.white)

                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)

                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
            }
            .safeAreaInset(edge: .bottom) {
                Button("Sign In") {
                    print("Login")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)
            }
        }
    }
}
