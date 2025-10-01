//
//  CbLoginViewController.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/10/25.
//


import UIKit
import Combine
import CombineCocoa

class CbLoginViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = CbLoginViewModel()
    
    
    @IBOutlet private weak var emailTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var resultMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingViewModel()
    }
    
    private func setupUI() {
        loginButton.isEnabled = false
    }
    
    let emailTrigger = PassthroughSubject<String, Never>()
    let passwordTrigger = PassthroughSubject<String, Never>()
    let loginButtonTrigger = PassthroughSubject<Void, Never>()
    
    private func bindingViewModel() {
        
        emailTextfield
            .textPublisher
            .sink { [weak self] email in
                guard let self else { return }
                guard let email = email else { return }
                self.emailTrigger.send(email)
            }.store(in: &cancellables)
        
        passwordTextfield.textPublisher
            .sink { [weak self] password in
                guard let self else { return }
                guard let password = password else { return }
                self.passwordTrigger.send(password)
            }.store(in: &cancellables)
        
        loginButton.tapPublisher
            .throttle(for: .milliseconds(500), scheduler: RunLoop.main, latest: false)
            .sink { [weak self] _ in
                guard let self else { return }
                self.loginButton.isEnabled = false
                self.loginButtonTrigger.send()
            }.store(in: &cancellables)
        
        let input = CbLoginViewModel.Input(email: emailTrigger.eraseToAnyPublisher(),
                                           password: passwordTrigger.eraseToAnyPublisher(),
                                           loginButtonTrigger: loginButtonTrigger.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    print("Loading...")
                } else {
                    print("Done")
                }
                self.loginButton.isEnabled = !isLoading
            }.store(in: &cancellables)
        
        output.isEnableLoginButton
            .sink { [weak self] isEnable in
                guard let self else { return }
                self.loginButton.isEnabled = isEnable
            }.store(in: &cancellables)
        
        
        output.loginResult
            .sink { [weak self] loginResult in
                guard let self else { return }
                if let loginResult = loginResult {
                    print(loginResult.isSuccess ? "Login Success" : "Login Failed")
                    self.resultMessage.text = loginResult.isSuccess ? "Token: \(String(describing: loginResult.token))" : "Login Failed"
                }
            }.store(in: &cancellables)
        
        output.error
            .sink { [weak self] error in
                guard let self else { return }
                self.handleError(with: error)
            }.store(in: &cancellables)
        
        emailTrigger
            .map { str in
                return "string \(str)"
            }
            .assign(to: \.text, on: resultMessage)
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}

extension CbLoginViewController {
    private func handleError(with error: Error?) {
        switch error {
        case let error as CbLoginEmailError:
            resultMessage.text = error.localizedDescription
        case let error as CbLoginPasswordError:
            resultMessage.text = error.localizedDescription
        case let error as CbLoginError:
            resultMessage.text = error.localizedDescription
        default:
            resultMessage.text = nil
        }
    }
}
