//
//  FakeStoreAuthService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/11/25.
//


import Alamofire
import Foundation

enum FakeStoreAuthRequest: URLRequestConvertible {
    case login(parameters: Parameters)
    case refreshToken(refreshToken: String)
    case getProfile
    
    private var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .refreshToken:
            return "/auth/refresh-token"
        case .getProfile:
            return "/auth/profile"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .login, .refreshToken:
            return .post
        case .getProfile:
            return .get
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .login(let parameters):
            return parameters
        case .refreshToken(let refreshToken):
            return ["refreshToken": refreshToken]
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Env.baseURL.asURL() // Alamofire .asURL()
        // Setup baseURL with path url
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Setup Method
        urlRequest.httpMethod = method.rawValue
        
        // Setup default Headers if needed
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Encoding parameter to request
        if let parameters = parameters {
            switch method {
            case .get:
                // GET: Parameters are encoded into the URL (URLEncoding)
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            case .post, .put, .patch:
                // POST/PUT: Parameters are encoded in the body (JSONEncoding or other)
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            default:
                break
            }
        }
        
        return urlRequest
    }
}
