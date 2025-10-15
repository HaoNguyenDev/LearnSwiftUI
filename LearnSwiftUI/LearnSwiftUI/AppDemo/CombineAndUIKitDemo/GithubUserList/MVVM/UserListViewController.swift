//
//  UserListViewController.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/10/25.
//

import UIKit
import Combine

// MARK: - User List View Controller (UIKit)
class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel = UserListViewModel()
    private var tableView = UITableView()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Users (Combine)"
        setupTableView()
        setupBindings()
        
        viewModel.loadUsers(isLoadMore: false)
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        view.addSubview(tableView)
        
        // Loading indicator for footer
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.center = footer.center
        footer.addSubview(spinner)
        tableView.tableFooterView = footer
        tableView.tableFooterView?.isHidden = true // default hide footerview
    }
    
 
    private func setupBindings() {
        viewModel.usersPublisher
            .sink { [weak self] users in
                self?.tableView.reloadData() // update UI when usersPublisher have any change
                self?.tableView.tableFooterView?.isHidden = true // Hide loading when finished
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersPublisher.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = viewModel.usersPublisher.value[indexPath.row]
        
        cell.textLabel?.text = "ID: \(user.id ?? 0) - Name: \(user.login.orEmpty)"
        
        return cell
    }
    
    // MARK: - Load More Logic
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Check user scrolled to en of the page
        if offsetY > contentHeight - height * 1.5 {
            if tableView.tableFooterView?.isHidden == true {
                tableView.tableFooterView?.isHidden = false
                viewModel.fetchNextPage()
            }
        }
    }
}


//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        // Create window
//        window = UIWindow(frame: UIScreen.main.bounds)
//
//        // Create root view controller
//        let rootVC = UserListViewController()
//        let navController = UINavigationController(rootViewController: rootVC)
//
//        // Setup UI
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
//
//        return true
//    }
//}
