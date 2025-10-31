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

final class AuthInterceptor: RequestInterceptor {
    private let tokenRefresher: AuthTokenRefresher
    let keychain: Keychain
    
    init(tokenRefresher: AuthTokenRefresher) {
        self.tokenRefresher = tokenRefresher
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
            tokenRefresher.refreshAccessToken { result in
                switch result {
                case .success(_):
                    // Token refresh successful -> Request will be retried.
                    // keychain[KeychainKeys.token] = data.token
                    // keychain[KeychainKeys.refreshToken] = data.token
                    // The adapt function will automatically add the new token to the request.
                    completion(.retry)
                case .failure:
                    completion(.doNotRetryWithError(error))
                }
            }
            // End the function here after handling 401 || 403
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
}
