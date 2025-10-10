//
//  File.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//


import Foundation
import SwiftUI
import RswiftResources

extension RswiftResources.FontResource {
    func font(size: CGFloat) -> Font {
      Font.custom(name, size: size)
    }
}