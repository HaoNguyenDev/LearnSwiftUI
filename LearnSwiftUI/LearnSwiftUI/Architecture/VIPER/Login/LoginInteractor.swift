//
//  LoginInteractor.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//


class LoginInteractor: LoginInteractorProtocol {
    // Can have a reference to an API service
    weak var presenter: LoginPresenter?
    
    func performLogin(with credentials: LoginCredentials) {
        // Simulate an API call
        // Example: LoginService.login(credentials) { result in ... }
        
        // Suppose the API returns successfully:
        let dummyUser = User(name: "John Doe")
        presenter?.loginDidSucceed(user: dummyUser)
        
        // Suppose the API returns a failure:
        // presenter?.loginDidFail(error: someError)
    }
}
