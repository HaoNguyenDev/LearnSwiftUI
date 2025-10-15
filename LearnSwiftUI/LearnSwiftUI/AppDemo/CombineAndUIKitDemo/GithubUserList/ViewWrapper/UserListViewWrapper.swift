//
//  GithubUsersViewWrapper.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/10/25.
//

import SwiftUI
import UIKit

struct GithubUsersViewWrapper: UIViewControllerRepresentable {
    
    // Required: Defines the type of UIViewController this struct represents
    typealias UIViewControllerType = UserListViewController
    
    // Required: Method for creating and configuring an initial UIViewController
    func makeUIViewController(context: Context) -> UserListViewController {
        // Initialize your UIViewController
        let myVC = UserListViewController()
        return myVC
    }
    
    // Required: Method for updating a UIViewController when the SwiftUI state changes
    func updateUIViewController(_ uiViewController: UserListViewController, context: Context) {
        // Update the view controller if bindings or @State change
    }
}
