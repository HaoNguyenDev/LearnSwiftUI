//
//  TokenResponse.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/11/25.
//

import Foundation

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    
    init (accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}
