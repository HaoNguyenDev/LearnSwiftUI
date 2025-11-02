//
//  AlamofireNetworking.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/11/25.
//

import Alamofire

protocol NetworkingProtocol {
    func getProfile() async throws -> Profile
    func getProducts() async throws -> [Product]
}

class AlamofireNetworking: NetworkingProtocol {
    
    static let shared = AlamofireNetworking()
    
    // Initialize AuthService and AuthInterceptor
    private let authService = AuthService.shared
    private let authInterceptor: AuthInterceptor
    
    // Alamofire Session Manager, integrated with Interceptor
    private let session: Session
    
    private init() {
        self.authInterceptor = AuthInterceptor(authService: authService)
        // Configure Session with custom interceptor
        self.session = Session(interceptor: authInterceptor)
    }
    
    /// Generic method to perform secure (protected) API requests.
    ///
    /// - Parameters:
    ///   - url: The URL endpoint.
    ///   - method: The HTTP method.
    ///   - parameters: Request parameters (if any).
    /// - Returns: Decoded data of type T.
    func request<T: Decodable>(url: String, method: HTTPMethod, parameters: [String: Any]? = nil) async throws -> T {
        debugPrint("\n⚡️ Networking: Starting API call: \(url) (\(method.rawValue))")
        
        do {
            let value = try await session.request(url, method: method, parameters: parameters)
                .validate() // Validate HTTP status code (200-299)
                .serializingDecodable(T.self)
                .value
            
            debugPrint("✅ Networking: API \(url) call successful.")
            return value
            
        } catch let afError as AFError {
            // Handle Alamofire errors in more detail
            debugPrint("❌ Networking: AFError in request: \(afError.localizedDescription)")
            throw afError // Re-throw Alamofire error
        } catch {
            // Handle other errors
            debugPrint("❌ Networking: General error in request: \(error.localizedDescription)")
            throw error
        }
    }
    
    func request<T: Decodable>(_ request: URLRequestConvertible) async throws -> T {
        debugPrint("\n⚡️ Networking: Starting API call: \(String(describing: request.urlRequest))")
        
        do {
            let value = try await session.request(request)
                .validate() // Validate HTTP status code (200-299)
                .serializingDecodable(T.self)
                .value
            
            debugPrint("✅ Networking: API \(String(describing: request.urlRequest)) call successful.")
            return value
            
        } catch let afError as AFError {
            // Handle Alamofire errors in more detail
            debugPrint("❌ Networking: AFError in request: \(afError.localizedDescription)")
            throw afError // Re-throw Alamofire error
        } catch {
            // Handle other errors
            debugPrint("❌ Networking: General error in request: \(error.localizedDescription)")
            throw error
        }
    }
}

extension AlamofireNetworking {
    // (example for an endpoint requiring Auth).
    func getProfile() async throws -> Profile {
        let getProfile = FakeStoreAuthRequest.getProfile
        return try await request(getProfile)
    }
    
    func getProducts() async throws -> [Product] {
        let getProducts = FakeStoreCommonRequest.getProduct
        return try await request(getProducts)
    }
}


