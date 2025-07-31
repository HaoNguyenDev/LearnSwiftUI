//
//  AppSettings.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/7/25.
//

import Foundation
import SwiftUI

// Bước 1: Định nghĩa EnvironmentKey tùy chỉnh
enum FontSizeEnvironment: EnvironmentKey {
    static let defaultValue = 20.0 // Giá trị mặc định
}

class AppSettings: ObservableObject {
    @Published var theme: String = "light"
    @Published var showIntro: Bool = true
}
