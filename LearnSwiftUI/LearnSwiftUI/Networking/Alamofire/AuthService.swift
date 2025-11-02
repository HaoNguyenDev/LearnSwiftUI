//
//  AuthService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/10/25.
//

import Alamofire
import Foundation

actor AuthService {
    private let baseURL = "https://api.escuelajs.co/api/v1"
    static let shared = AuthService()
    private typealias RetryHandler = (Result<String, Error>) -> Void
    private var isRefreshing = false
    private var requestsToRetry: [RetryHandler] = []
    
    nonisolated var currentAccessToken: String? {
        return KeychainStore.shared.getString(forKey: .accessToken)
    }
    
    nonisolated var currentRefreshToken: String? {
        return KeychainStore.shared.getString(forKey: .refreshToken)
    }
    
    nonisolated private func saveTokens(response: TokenResponse) {
        KeychainStore.shared.set(response.accessToken, forKey: .accessToken)
        KeychainStore.shared.set(response.refreshToken, forKey: .refreshToken)
    }
    
    func login(request: LoginRequest) async throws -> TokenResponse {
        let url = "\(baseURL)/auth/login"
        
        do {
            let response = try await AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
                .validate()
                .serializingDecodable(TokenResponse.self)
                .value
            
            debugPrint("✅ AuthService: Login successful and token saved.")
            self.saveTokens(response: response)
            return response
        } catch {
            debugPrint("❌ AuthService: Login failed. Error: \(error.localizedDescription)")
            throw AuthServiceError.loginFailed(NSError(domain: "AuthService", code: error.asAFError?.responseCode ?? 0, userInfo: [NSLocalizedDescriptionKey : error.localizedDescription]))
        }
    }
    
    func refreshToken() async throws -> TokenResponse {
        // The actor ensures that only one Task can access this state at a time.
        // Ensure isRefreshing is reset when the function finishes (successfully or unsuccessfully)
        defer {
            self.isRefreshing = false
        }
        
        // Avoid race conditions by checking again
        guard !isRefreshing else {
            // Wait for the current token refresh request to complete.
            return try await withCheckedThrowingContinuation { continuation in
                // Add the closure to requestsToRetry.
                // This closure will be called when the refresh token is complete.
                requestsToRetry.append { result in
                    switch result {
                    case .success(let token):
                        // Token successfully refreshed, return the new token
                        debugPrint("Requests in [requestsToRetry] resolved with new token \(token).")
                        continuation.resume(returning: TokenResponse(accessToken: token, refreshToken: ""))
                    case .failure(let error):
                        // Refresh token failed, throw error
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        
        self.isRefreshing = true
        
        // Access nonisolated property
        guard let currentRefreshToken = self.currentRefreshToken else {
            // Notify all pending requests before throwing an error
            requestsToRetry.forEach { $0(.failure(AuthServiceError.missingToken)) }
            requestsToRetry.removeAll()
            throw AuthServiceError.missingToken
        }
        
        debugPrint("🔄 AuthService: Calling refresh token API...")
        
        let url = "\(baseURL)/auth/refresh-token"
        let parameters = ["refreshToken": currentRefreshToken]
        
        do {
            let response = try await AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
                .validate()
                .serializingDecodable(TokenResponse.self)
                .value
            
            // Save new tokens
            self.saveTokens(response: response)
            debugPrint("✅ AuthService: Token refresh successful.")
            
            // Get the newly saved token to return and notify pending requests
            guard let newAccessToken = self.currentAccessToken else {
                requestsToRetry.forEach { $0(.failure(AuthServiceError.retryHandlerMissingToken)) }
                requestsToRetry.removeAll()
                throw AuthServiceError.retryHandlerMissingToken
            }
            
            // Notify pending requests of success
            requestsToRetry.forEach { $0(.success(newAccessToken)) }
            requestsToRetry.removeAll()
            
            return response
            
        } catch {
            // Clear old tokens
            KeychainStore.shared.clearAccessToken()
            debugPrint("❌ AuthService: Token refresh failed. Error: \(error.localizedDescription)")
            
            // Notify pending requests of failure requestsToRetry.forEach { $0(.failure(AuthServiceError.refreshTokenFailed)) }
            requestsToRetry.removeAll()
            
            throw AuthServiceError.refreshTokenFailed
        }
    }
}
