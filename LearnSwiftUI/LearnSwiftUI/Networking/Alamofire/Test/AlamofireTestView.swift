//
//  AlamofireTestView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/11/25.
//

import Foundation
import SwiftUI

struct AlamofireTestView: View {
    var body: some View {
        Text("AlamofireTestView")
            .onAppear {
                Task {
                    let authService = AuthService.shared
                    let networking = AlamofireNetworking.shared
                    
                    // --- 1. Log in to get the initial token ---
                    print("\n--- STEP 1: Initial Login ---")
                    let loginRequest = LoginRequest(email: "john@mail.com", password: "changeme")
                    
                    do {
                        // Call the actor method requiring `await`
                        _ = try await authService.login(request: loginRequest)
                        print("=============================================")
                        
                        // --- 2. Call the first API with the current token (Should succeed) ---
                        print("\n--- STEP 2: Call Profile API (Attempt 1) ---")
                        let profile1 = try await networking.getProfile()
                        print("✅ Attempt 1: Retrieved profile1 \(profile1.email.orEmpty).")
                        
                        // Simulate invalidating the Access Token to trigger the Refresh Logic (401/403)
                        KeychainStore.shared.clearToken()
                        print("⚠️ Simulation: Access Token has been invalidated (INVALID_ACCESS_TOKEN).")
                        print("=============================================")
                        
                        // --- 3. Call the API again (Will fail, Interceptor will refresh the token and Retry) ---
                        print("\n--- STEP 3: Call Profile API (Attempt 2 - Trigger Refresh Token) ---")
                        
                        let profile2 = try await networking.getProfile()
                        print("✅ Attempt 2: Retrieved profile2 \(profile2.email.orEmpty) after successful Refresh and Retry.")
                        
                    } catch {
                        print("\n=============================================")
                        print("❌ CRITICAL ERROR: Main process failed. Error: \(error.localizedDescription)")
                        
                        if let afError = error.asAFError, case .responseValidationFailed(reason: .unacceptableStatusCode(code: let code)) = afError {
                            print("Details: HTTP Status Code \(code).")
                        }
                    }
                    
                    // Clean up tokens after running the example
                    KeychainStore.shared.clearAllKeys()
                }
            }
    }
    
}
