//
//  Router.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import Foundation

protocol Routable: Identifiable, Hashable {
    var id: String { get }
}

struct Presentable: Identifiable {
    let id = UUID()
    let routerable: any Routable
}

enum Router { }


