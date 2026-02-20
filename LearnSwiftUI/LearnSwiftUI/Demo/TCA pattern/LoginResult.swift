//
//  LoginResult.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

enum LoginResult: Equatable {
    case success(token: String)
    case failure(LoginError)
}
