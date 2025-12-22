//
//  Router.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import Foundation

protocol Routerable: Identifiable, Hashable {
    var id: String { get }
}

struct RouterView: Identifiable {
    let id = UUID()
    let routerable: any Routerable
}

enum Router { }


