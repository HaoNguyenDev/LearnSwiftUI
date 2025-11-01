//
//  AlamofireNetworking.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/11/25.
//

import Alamofire

class AlamofireNetworking {
    
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
        print("\n⚡️ Networking: Starting API call: \(url) (\(method.rawValue))")
        
        do {
            let value = try await session.request(url, method: method, parameters: parameters)
                .validate() // Validate HTTP status code (200-299)
                .serializingDecodable(T.self)
                .value
            
            print("✅ Networking: API call successful.")
            return value
            
        } catch let afError as AFError {
            // Handle Alamofire errors in more detail
            print("❌ Networking: AFError in request: \(afError.localizedDescription)")
            throw afError // Re-throw Alamofire error
        } catch {
            // Handle other errors
            print("❌ Networking: General error in request: \(error.localizedDescription)")
            throw error
        }
    }
}

protocol APIListProtocol {
    func getProfile() async throws -> Profile
    func getProducts() async throws -> [Product]
}

extension AlamofireNetworking: APIListProtocol {
    // (example for an endpoint requiring Auth).
    func getProfile() async throws -> Profile {
        debugPrint("Networking: Calling /auth/profile")
        let url = "https://api.escuelajs.co/api/v1/auth/profile"
        return try await request(url: url, method: .get)
    }
    
    func getProducts() async throws -> [Product] {
        debugPrint("Networking: Calling /products")
        let url = "https://api.escuelajs.co/api/v1/products"
        return try await request(url: url, method: .get)
    }
}


