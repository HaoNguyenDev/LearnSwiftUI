//
//  Product.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/11/25.
//

import Foundation
struct Product : Codable {
    let id : Int?
    let title : String?
    let slug : String?
    let price : Int?
    let description : String?
    let category : Category?
    let images : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case slug = "slug"
        case price = "price"
        case description = "description"
        case category = "category"
        case images = "images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        category = try values.decodeIfPresent(Category.self, forKey: .category)
        images = try values.decodeIfPresent([String].self, forKey: .images)
    }

}
