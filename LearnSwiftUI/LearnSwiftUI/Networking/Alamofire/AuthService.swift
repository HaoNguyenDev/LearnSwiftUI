//
//  AuthService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/10/25.
//

import Alamofire
import Foundation
@preconcurrency import KeychainAccess

protocol AuthTokenRefresher: Sendable {
    func refreshAccessToken(completion: @escaping (Result<Data?, Error>) -> Void)
}

final class AuthService: AuthTokenRefresher {
    let keychain: Keychain
    
    init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    func refreshAccessToken(completion: @escaping (Result<Data?, Error>) -> Void) {
        // Retrieve refresh token from Keychain
        guard let refreshToken = keychain[KeychainService.KeychainKeys.refreshToken.rawValue] else {
            // No refresh token -> Requires re-login
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            return
        }
        
        // **Perform network call to refresh token using Alamofire**
        // Example:
        AF.request("YOUR_REFRESH_ENDPOINT", method: .post, parameters: ["refresh_token": refreshToken])
            .response { response in
                // ... Process the response and save the new token to Keychain ...
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
