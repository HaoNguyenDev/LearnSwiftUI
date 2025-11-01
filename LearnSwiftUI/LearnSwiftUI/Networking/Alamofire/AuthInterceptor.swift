//
//  AuthInterceptor.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/10/25.
//


import Alamofire
import Foundation

/// Manages adding the Access Token to the header and handling 401/403 errors.
final class AuthInterceptor: RequestInterceptor, @unchecked Sendable {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    // MARK: - Adapt (Add Access Token)
    
    /// Inserts the Access Token into the "Authorization" header for every request.
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        // currentAccessToken is nonisolated, so no await is needed
        guard let accessToken = authService.currentAccessToken else {
            // If there's no token, continue the request (possibly a public endpoint)
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        debugPrint("➡️ Interceptor: Inserted Access Token into request: \(urlRequest.url?.lastPathComponent ?? "N/A")")
        completion(.success(urlRequest))
    }
    
    // MARK: - Retry (Handle 401/403 errors)
    
    /// Handles token refresh and retries the request when authentication errors occur.
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let response = request.task?.response as? HTTPURLResponse else {
            // For non-HTTP errors (e.g., network loss, timeout), retry if needed
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorTimedOut {
                debugPrint("⚠️ Interceptor: Timeout error, retrying request.")
                completion(.retry) // Example: retry timeout errors
            } else {
                debugPrint("❌ Interceptor: Non-HTTP error, not retrying: \(error.localizedDescription)")
                completion(.doNotRetry)
            }
            return
        }
        
        let statusCode = response.statusCode
        
        // 1. Check for 401 or 403 errors (Unauthorized/Forbidden errors)
        if 401...403 ~= statusCode {
            debugPrint("🚨 Interceptor: Received error \(statusCode). Refresh Token needed.")
            
            // currentRefreshToken is non-isolated, so no await is needed
            guard authService.currentRefreshToken != nil else {
                debugPrint("🚫 Interceptor: Refresh Token does not exist. Re-login required.")
                completion(.doNotRetry)
                return
            }
            
            // Call refreshToken function, using `Task` and **await** (because authService is an Actor)
            Task {
                do {
                    // Try refreshing the token
                    let _ = try await authService.refreshToken()
                    
                    // If refresh is successful, retry the original request.
                    // Adapt will automatically insert the new token before retrying.
                    debugPrint("✅ Interceptor: Refresh successful. Retrying the original request.")
                    completion(.retry)
                } catch {
                    // If refresh fails, do not retry
                    debugPrint("❌ Interceptor: Refresh failed. Request will not be retried.")
                    completion(.doNotRetry)
                }
            }
            
        } else if statusCode == 500 {
            // 2. Handle server errors (e.g., 500 error)
            debugPrint("⚠️ Interceptor: Received 500 error (Internal Server Error). Retrying after 1 second.")
            completion(.retryWithDelay(1.0)) // Example: retry server error after 1 second
            
        } else {
            // 3. Other errors (e.g., 404, 400,...)
            debugPrint("❌ Interceptor: Error \(statusCode) does not require retry.")
            completion(.doNotRetry)
        }
    }
}
