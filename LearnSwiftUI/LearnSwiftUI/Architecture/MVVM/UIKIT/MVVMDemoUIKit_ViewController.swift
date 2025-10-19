//
//  MVVMDemoUIKit_ViewController.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/10/25.
//

import UIKit
import Combine

class MVVMDemoUIKit_ViewController: UIViewController, UITableViewDelegate {
    
    private let vm = MVVMDemoUIKit_ViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var error: Error?
    private var inputedString: String?
    private var users: [GithubUser]?
    
    private var tableView = UITableView()
    
    // MARK: - Internal Subjects
    private let inputStringTrigger = PassthroughSubject<String?, Never>()
    private let viewDidloadTrigger = PassthroughSubject<Void, Never>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupTableView()
        setupBindings()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        view.addSubview(tableView)
    }
    
    private func setupBindings() {
        let input = MVVMDemoUIKit_ViewModel.Input(inputString: inputStringTrigger.eraseToAnyPublisher(),
                                                  viewDidloadTrigger: viewDidloadTrigger.eraseToAnyPublisher())
        let output = vm.transform(input: input)
        
        output.errorResult
            .sink { [weak self] error in
                self?.error = error
            }.store(in: &cancellables)
        
        output.stringResult
            .sink { [weak self] string in
                self?.inputedString = string
                Logger.shared.debug(string.orEmpty)
            }.store(in: &cancellables)
        
        output.userListResult
            .sink { [weak self] users in
                self?.users = users
                self?.tableView.reloadData()
                self?.tableView.tableFooterView?.isHidden = true
            }.store(in: &cancellables)
        
        inputStringTrigger.send("Hello, world!")
        viewDidloadTrigger.send(())
    }
}

extension MVVMDemoUIKit_ViewController: UITableViewDataSource {
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        if let users = users, let user = users[safe: indexPath.row] {
            cell.textLabel?.text = "ID: \(user.id ?? 0) - Name: \(user.login.orEmpty)"
            return cell
        }
        return UITableViewCell()
    }
}
