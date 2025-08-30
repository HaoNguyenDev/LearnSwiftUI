//
//  GithubUser.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/8/25.
//

import Foundation

struct GithubUser: Decodable, Identifiable, Equatable {
    var id: Int?
    var login: String?
    var avatarUrl: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case avatarUrl = "avatar_url"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    static func == (lhs: GithubUser, rhs: GithubUser) -> Bool {
        lhs.id == rhs.id
    }
    
    init(id: Int? = nil,
         login: String? = nil,
         avatarUrl: String? = nil,
         url: String? = nil) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.url = url
    }
}
