//
//  CombineDefinitionViewWrapper.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/10/25.
//

import SwiftUI
import UIKit

struct CombineDefinitionViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let homeVC = CombineDefinitionHomeVC()
        return UINavigationController(rootViewController: homeVC)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
