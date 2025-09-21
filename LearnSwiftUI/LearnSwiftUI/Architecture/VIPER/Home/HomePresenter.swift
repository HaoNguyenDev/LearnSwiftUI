//
//  HomePresenter.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/9/25.
//


class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    func viewDidLoad() {
        // When the View has loaded, ask the Interactor to get data
        interactor?.fetchUserData()
    }
    
    func logoutButtonTapped() {
        // Ask the Router to navigate
        router?.navigateToLoginScreen()
    }
    
    // Get data from the Interactor and ask the View to display
    func userDidReceive(_ user: User) {
        view?.displayUser(name: user.name)
    }
}
