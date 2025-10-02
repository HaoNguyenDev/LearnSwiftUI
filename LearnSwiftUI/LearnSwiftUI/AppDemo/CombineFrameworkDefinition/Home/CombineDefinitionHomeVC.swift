//
//  CombineDefinitionHomeVC.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/10/25.
//

import UIKit
import Combine

class CombineDefinitionHomeVC: UIViewController {
    private let viewModel = CombineDefinitionHomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        title = "Combine Publishers, Subscribers & Operators"
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$selectedItem
            .sink { [weak self] item in
                guard let item = item else { return }
                DispatchQueue.main.async { [weak self] in
                    let vc = CombineItemDetailVC(item: item)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .store(in: &cancellables)
    }
}

extension CombineDefinitionHomeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return viewModel.publishers.count
        case 1: return viewModel.subscribers.count
        case 2: return viewModel.operators.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item: CombineItem
        switch indexPath.section {
        case 0: item = viewModel.publishers[indexPath.row]
        case 1: item = viewModel.subscribers[indexPath.row]
        case 2: item = viewModel.operators[indexPath.row]
        default: fatalError("Invalid section")
        }
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Publishers"
        case 1: return "Subscribers"
        case 2: return "Operators"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: CombineItem
        switch indexPath.section {
        case 0: item = viewModel.publishers[indexPath.row]
        case 1: item = viewModel.subscribers[indexPath.row]
        case 2: item = viewModel.operators[indexPath.row]
        default: fatalError("Invalid section")
        }
        viewModel.selectItem(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
