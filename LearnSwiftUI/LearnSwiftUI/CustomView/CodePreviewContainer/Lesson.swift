//
//  Lesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/1/26.
//

import SwiftUI

struct Lesson: Identifiable {
    let id = UUID()
    let isSectionTitle: Bool = false
    let title: String
    let code: String
    let result: (() -> AnyView)?
}
