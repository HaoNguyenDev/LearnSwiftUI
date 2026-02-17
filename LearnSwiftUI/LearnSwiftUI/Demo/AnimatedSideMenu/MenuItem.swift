//
//  MenuItem.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 17/2/26.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
    var color: Color
}

extension MenuItem {
    static let menuItems = [
        MenuItem(icon: "house.fill", title: "Home", color: .blue),
        MenuItem(icon: "person.fill", title: "Profile", color: .purple),
        MenuItem(icon: "bell.fill", title: "Notifications", color: .red),
        MenuItem(icon: "gearshape.fill", title: "Settings", color: .orange),
        MenuItem(icon: "star.fill", title: "Favorites", color: .yellow),
        MenuItem(icon: "envelope.fill", title: "Messages", color: .green),
    ]
}
