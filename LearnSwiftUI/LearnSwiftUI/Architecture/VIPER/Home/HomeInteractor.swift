//
//  HomeInteractor.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//


class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?
    
    func fetchUserData() {
        // Simulate fetching user data from somewhere
        let user = User(name: "Alice")
        
        // Send data to Presenter
        presenter?.userDidReceive(user)
    }
}
