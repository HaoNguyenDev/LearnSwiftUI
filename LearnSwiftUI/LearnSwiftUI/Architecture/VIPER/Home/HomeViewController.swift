//
//  HomeViewController.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    
    // Suppose there is a UILabel and UIButton in the Storyboard
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tell Presenter that the View is ready
        presenter?.viewDidLoad()
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        // Forward the event to Presenter
        presenter?.logoutButtonTapped()
    }
    
    // Method to display data
    func displayUser(name: String) {
        userNameLabel.text = "Welcome, \(name)!"
    }
}
