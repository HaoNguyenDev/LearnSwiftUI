//
//  LoginViewController.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {

    
    var presenter: LoginPresenterProtocol?

    // Các thành phần UI:
     @IBOutlet weak var usernameTextField: UITextField!
     @IBOutlet weak var passwordTextField: UITextField!
     @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Chuyển tiếp sự kiện đến Presenter
        presenter?.loginButtonTapped(username: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    func displayError(_ message: String) {
        // Hiển thị lỗi trên màn hình
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
    }

    // Các phương thức khác: showLoadingIndicator, hideLoadingIndicator
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
}
