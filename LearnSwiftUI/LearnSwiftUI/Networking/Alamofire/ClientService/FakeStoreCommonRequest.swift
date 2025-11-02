//
//  FakeStoreCommonRequest.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/11/25.
//

import Alamofire
import Foundation

enum FakeStoreCommonRequest: URLRequestConvertible {
    case getProduct
    
    private var path: String {
        switch self {
        case .getProduct:
            return "/products"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getProduct:
            return .get
        }
    }
    
    private var parameters: Parameters? {
        switch self {
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
