//
//  AuthInterceptor.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/10/25.
//


import Alamofire
import Foundation

@preconcurrency
import KeychainAccess

final class CustomInterceptor: RequestInterceptor {
    let keychain: Keychain
    
    init() {
        self.keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "haonguyen.LearnSwiftUI")
    }
    
    // MARK: - Adapt
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        // Set access token
        if let accessToken = keychain[KeychainService.KeychainKeys.token.rawValue] {
            // Add Authorization header to any request
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        // completion with URLRequest adapted
        completion(.success(urlRequest))
    }
    
    // MARK: - Retry
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        // --- DECLARE NECESSARY PARAMETERS ---
        let maxRetries = 3
        
        // --- 1. HANDLE AUTHENTICATION ERROR (401) FIRST ---
        
        // Get HTTP status code (if available)
        if let response = request.response, response.statusCode == 401 || response.statusCode == 403 {
            // Check for 401 || 403 error: Token expired/invalid
            
            // **Important:** This refreshToken function must be defined in your class/struct
            // and must call the API to refresh the token.
            refreshToken { isSuccess in
                if isSuccess {
                    // Token refresh successful -> Request will be retried.
                    // The adapt function will automatically add the new token to the request.
                    completion(.retry)
                } else {
                    // Token refresh failed -> Do not retry and report error.
                    // Usually leads to logging out the user.
                    completion(.doNotRetryWithError(error))
                }
            }
            // End the function here after handling 401
            return
        }
        
        // --- 2. HANDLE NETWORK ERRORS ---
        
        // Check for common network errors such as timeout or connection loss
        if let urlError = error.asAFError?.underlyingError as? URLError,
           urlError.code == .timedOut || urlError.code == .notConnectedToInternet {
            
            // Check the number of retries (applies to both 401 and network errors)
            if request.retryCount < maxRetries {
                // Retry after 2 seconds (Backoff Strategy)
                print("[\(self)] ⚠️ Network error. Retrying attempt \(request.retryCount + 1)/\(maxRetries) after 2.0 seconds.")
                return completion(.retryWithDelay(2.0))
            } else {
                // Maximum number of retries exceeded for network errors
                print("[\(self)] ❌ Network error: Maximum retry limit reached (\(maxRetries) times).")
                return completion(.doNotRetry)
            }
        }
        
        // --- 3. HANDLING OTHER ERRORS ---
        
        // If the error is not 401 and not a network error (e.g., 400, 403, 500...),
        // we do not retry because it is usually a logic error or the server cannot fix it itself.
        debugPrint("[\(self)] 🛑 Other error, cannot retry. Error code: \(request.response?.statusCode ?? -1)")
        completion(.doNotRetry)
    }
    
    // MARK: - Refresh Token
    private func refreshToken(completion: @escaping (Bool) -> Void) {
        // ... refresh token logic ...
        // Alamofire.request(...)
        // completion(true/false)
        
        // Mock result with always success
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(true)
        }
    }
}
