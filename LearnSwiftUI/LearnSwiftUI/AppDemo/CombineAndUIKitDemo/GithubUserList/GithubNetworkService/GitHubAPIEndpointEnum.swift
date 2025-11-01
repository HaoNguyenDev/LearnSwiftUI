//
//  GitHubAPIEndpointEnum.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/10/25.
//

import Foundation

// MARK: - GitHub API Endpoints
enum GitHubAPIEndpointEnum: Endpoint {
    
    // Sử dụng giá trị liên kết để truyền tham số
    case getUsers(since: Int, perPage: Int)
    case getUserDetail(username: String)
    
    var baseURL: String {
        return "https://api.github.com"
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUserDetail(let username):
            return "/users/\(username)"
        }
    }
    
    var method: _HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.github.v3+json"]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getUsers(let since, let perPage):
            return [
                URLQueryItem(name: "since", value: String(since)),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        case .getUserDetail:
            return nil
        }
    }
    
    var body: Data? {
        return nil 
    }
}
