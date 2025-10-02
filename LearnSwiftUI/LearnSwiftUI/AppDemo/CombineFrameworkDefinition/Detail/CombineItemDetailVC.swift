//
//  CombineItemDetailVC.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/10/25.
//


import UIKit

class CombineItemDetailVC: UIViewController {
    private let item: CombineItem
    private let textView = UITextView()
    
    init(item: CombineItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = item.name
        view.backgroundColor = .white
        
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = """
        **Definition**:
        \(item.description)
        
        **Code Demo**:
        \(item.codeDemo)
        """
        textView.font = .systemFont(ofSize: 16)
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
