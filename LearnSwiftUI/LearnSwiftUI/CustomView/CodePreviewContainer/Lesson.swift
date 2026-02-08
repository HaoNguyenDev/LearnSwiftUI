//
//  Lesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/1/26.
//

import SwiftUI

struct Lesson: Identifiable {
    let id: UUID
    let title: String
    let code: String?
    let result: (() -> AnyView)?
    
    init(title: String, code: String, result: (() -> AnyView)?) {
        self.id = UUID()
        self.title = title
        self.code = code
        self.result = result
    }
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.code = nil
        self.result = nil
    }
}
