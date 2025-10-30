//
//  Encodable.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/10/25.
//


import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        return json
    }
}