//
//  LoginView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = TCAPattern(initialState: LoginFeature.State(),
                                                    reducer: LoginFeature.reduce,
                                                    effectHandler: LoginFeature.handleEffect)
    @State private var showSuccess = false

    var body: some View {
        ZStack {
            Color(hex: "F7F6F3").ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    headerSection
                        .padding(.top, 64)
                        .padding(.bottom, 48)

                    formSection
                }
                .padding(.horizontal, 28)
            }

            if viewModel.state.isLoading {
                loadingOverlay
            }
        }
        .alert(
            "Login failed",
            isPresented: Binding(
                get: { viewModel.state.loginError != nil },
                set: { if !$0 { viewModel.send(.dismissLoginError) } }
            )
        ) {
            Button("Retry", role: .cancel) { viewModel.send(.dismissLoginError) }
        } message: {
            Text(viewModel.state.loginError ?? "")
        }
        .fullScreenCover(isPresented: $showSuccess) {
            SuccessView(email: viewModel.state.email) {
                viewModel.send(.resetForm)
                showSuccess = false
            }
        }
        .onChange(of: viewModel.state.isLoggedIn, { _ , newValue in
            if newValue { showSuccess = true }
        })
    }
}

// MARK: Subviews
private extension LoginView {

    var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome")
                .font(.system(size: 12, weight: .medium))
                .tracking(1)
                .textCase(.uppercase)
                .foregroundColor(Color(hex: "8A8880"))

            Text("Log in \nto your account")
                .font(.system(size: 34, weight: .light))
                .tracking(-1)
                .foregroundColor(Color(hex: "1A1A1A"))
                .lineSpacing(4)
        }
    }

    var formSection: some View {
        VStack(alignment: .leading, spacing: 20) {

            // Email field
            ValidatedEmailTextField(
                title: "Email",
                text: viewModel.binding(
                    get: \.email,
                    send: { .emailChanged($0) }
                ),
                error: viewModel.state.visibleEmailError,
                keyboardType: .emailAddress,
                textContentType: .emailAddress,
                onEndEditing: { viewModel.send(.emailDidEndEditing) }
            )

            // Password field
            VStack(alignment: .leading, spacing: 8) {
                ValidatedSecureField(
                    title: "Password",
                    text: viewModel.binding(
                        get: \.password,
                        send: { .passwordChanged($0) }
                    ),
                    error: viewModel.state.visiblePasswordError,
                    onEndEditing: { viewModel.send(.passwordDidEndEditing) }
                )

                // Real-time strength bar
                if !viewModel.state.password.isEmpty {
                    PasswordStrengthBar(
                        strength: Validator.passwordStrength(viewModel.state.password)
                    )
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel.state.password.isEmpty)

            // Forgot password
            HStack {
                Spacer()
                Button("Forgot your password?") {}
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "8A8880"))
            }
            .padding(.top, 4)

            // Submit button
            Button {
                viewModel.send(.submitTapped)
            } label: {
                Text("Login")
                    .font(.system(size: 15, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(
                        viewModel.state.isFormValid
                        ? Color(hex: "1A1A1A")
                        : Color(hex: "E2E0DA")
                    )
                    .foregroundColor(
                        viewModel.state.isFormValid
                        ? Color.white
                        : Color(hex: "8A8880")
                    )
                    .cornerRadius(10)
            }
            .disabled(!viewModel.state.isFormValid)
            .padding(.top, 8)
            .animation(.easeInOut(duration: 0.2), value: viewModel.state.isFormValid)

            // Register link
            HStack(spacing: 4) {
                Spacer()
                Text("Don't have an account yet?")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "8A8880"))
                Button("Register") {}
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(hex: "1A1A1A"))
                Spacer()
            }
            .padding(.top, 16)

            // Demo hint
            Text("Demo: test@example.com / Password1")
                .font(.system(size: 11, design: .monospaced))
                .foregroundColor(Color(hex: "C8C6C0"))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 8)
        }
    }

    var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.25).ignoresSafeArea()
            VStack(spacing: 14) {
                ProgressView()
                    .tint(Color(hex: "1A1A1A"))
                    .scaleEffect(1.2)
                Text("Logging in...")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "1A1A1A"))
            }
            .padding(32)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
    }
    
    private var loginSuccessView: some View {
        SuccessView(email: viewModel.state.email) {
            showSuccess = false
        }
    }
}

#Preview {
    LoginView()
}
