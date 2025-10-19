//
//  GithubUsersViewWrapper.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 19/10/25.
//


import SwiftUI
import UIKit

struct MVVMDemoUIKitViewWrapper: UIViewControllerRepresentable {
    
    // Required: Defines the type of UIViewController this struct represents
    typealias UIViewControllerType = MVVMDemoUIKit_ViewController
    
    // Required: Method for creating and configuring an initial UIViewController
    func makeUIViewController(context: Context) -> MVVMDemoUIKit_ViewController {
        // Initialize your UIViewController
        let myVC = MVVMDemoUIKit_ViewController()
        return myVC
    }
    
    // Required: Method for updating a UIViewController when the SwiftUI state changes
    func updateUIViewController(_ uiViewController: MVVMDemoUIKit_ViewController, context: Context) {
        // Update the view controller if bindings or @State change
    }
}
