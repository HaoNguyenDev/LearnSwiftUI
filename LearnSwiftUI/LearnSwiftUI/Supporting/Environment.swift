//
//  Environment.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/11/25.
//

import Foundation

final class Env {
    static let shared = Env()
    private init() {}

    static let baseURL = shared.value(for: "API_BASE_URL")
    
    private let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
}

extension Env {
    private func value(for key:String) -> String {
        guard let value = infoDict[key] as? String else {
            fatalError("\(key) is not set in plist for this environment")
        }
        return value
    }
}
