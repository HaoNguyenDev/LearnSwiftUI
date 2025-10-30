//
//  AuthInterceptor.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/10/25.
//


import Alamofire
import Foundation

final class AuthInterceptor: RequestInterceptor {

    // MARK: - Adapt
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        Task {
            // Set access token
            if let accessToken = await KeychainService.shared.getAccessToken() {
                // Add Authorization header to any request
                urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
        }
        
        // completion with URLRequest adapted
        completion(.success(urlRequest))
    }

    // MARK: - Retry
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        // Handle HTTP 401 error
        guard let response = request.response, response.statusCode == 401 else {
            // do not retry if error not 401
            return completion(.doNotRetry)
        }
        
        refreshToken { isSuccess in
            if isSuccess {
                // if refesh token success then retry request
                completion(.retry)
            } else {
                // if refesh token failed then do not retry and return error
                completion(.doNotRetryWithError(error))
            }
        }
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
