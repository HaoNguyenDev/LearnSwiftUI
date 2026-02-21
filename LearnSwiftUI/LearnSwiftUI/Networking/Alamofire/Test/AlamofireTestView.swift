//
//  AlamofireTestView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/11/25.
//

import Foundation
import SwiftUI

struct AlamofireTestView: View {
    let authService = AuthService.shared
    let networking: any NetworkingProtocol = AlamofireNetworking.shared
    
    var body: some View {
        Text("AlamofireTestView")
        VStack(spacing: 20) {
            // --- 1. Log in to get the initial token ---
            Group {
                Button("Login") {
                    doLogin()
                }
                
                Button("GET Profile") {
                    getProfile()
                }
                
                Button("Clear Access Token") {
                    debugPrint(">>> Cleared Access Token <<<")
                    KeychainStore.shared.clearAccessToken()
                }
                
            }
            .buttonStyle(.primaryHButton)
            .padding()
            
            
        }
        .onDisappear {
            KeychainStore.shared.clearAllKeys()
        }
    }
    
}

extension AlamofireTestView {
    private func doLogin() {
        Task {
            do {
                let loginRequest = LoginRequest(email: "john@mail.com", password: "changeme")
                let loginResponse = try await authService.login(request: loginRequest)
                debugPrint(loginResponse)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func getProfile() {
        Task {
            do {
                let profile = try await networking.getProfile()
                debugPrint(profile)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        debugPrint("❌ CRITICAL ERROR: Main process failed. Error: \(error.localizedDescription)")
        
        if let afError = error.asAFError, case .responseValidationFailed(reason: .unacceptableStatusCode(code: let code)) = afError {
            debugPrint("Details: HTTP Status Code \(code).")
        }
    }
}

#Preview {
    AlamofireTestView()
}
