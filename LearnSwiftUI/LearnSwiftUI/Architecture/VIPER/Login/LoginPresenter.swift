//
//  LoginPresenter.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//


class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?
    
    func loginButtonTapped(username: String, password: String) {
        // Test basic logic
        if username.isEmpty || password.isEmpty {
            view?.displayError("Please enter complete information.")
            return
        }
        view?.showLoadingIndicator()
        // Send business request to Interactor
        let credentials = LoginCredentials(username: username, password: password)
        interactor?.performLogin(with: credentials)
    }
    
    // Method from Interactor (after Interactor finished processing)
    func loginDidSucceed(user: User) {
        // Request Router to change screen
        view?.hideLoadingIndicator()
        router?.navigateToHomeScreen()
    }
    
    func loginDidFail(error: Error) {
        // Request View to display error
        view?.hideLoadingIndicator()
        view?.displayError(error.localizedDescription)
    }
}
