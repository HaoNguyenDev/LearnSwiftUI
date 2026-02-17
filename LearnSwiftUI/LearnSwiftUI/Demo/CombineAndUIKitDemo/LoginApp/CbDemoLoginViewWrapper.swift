//
//  CbDemoViewWrapper.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/10/25.
//

import SwiftUI
import UIKit

struct CbDemoLoginViewWrapper: UIViewControllerRepresentable {
    
    // Required: Defines the type of UIViewController this struct represents
    typealias UIViewControllerType = CbLoginViewController
    
    // Required: Method for creating and configuring an initial UIViewController
    func makeUIViewController(context: Context) -> CbLoginViewController {
        // Initialize your UIViewController
        let myVC = CbLoginViewController()
        return myVC
    }
    // Required: Method for updating a UIViewController when the SwiftUI state changes
    func updateUIViewController(_ uiViewController: CbLoginViewController, context: Context) {
        // Update the view controller if bindings or @State change
    }
}
