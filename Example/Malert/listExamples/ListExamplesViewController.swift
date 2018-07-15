//
//  ListExamplesViewController.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 15/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

enum ExampleType {
    case withImage
    case textField
    case customizable
    case expandable
    
    var color: UIColor {
        switch self {
        case .withImage:
            return .imageExample
        case .textField:
            return .formExample
        case .customizable:
            return .customizableExample
        case .expandable:
            return .expandableExample
        }
    }
}

class ListExamplesViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        return UITableView()
    }()
    
    private let examples: [ExampleType] = [.withImage, .textField, .customizable, .expandable]
    
    override func loadView() {
        super.loadView()
        addTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Examples"
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .primary
    }
}

extension ListExamplesViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func addTableView() {
        self.view.addSubview(tableView)
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        
        tableView.keyboardDismissMode = .interactive
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "ExampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as! ExampleTableViewCell
        cell.populateWith(type: examples[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = examples[indexPath.row]
        
        switch type {
        case .withImage:
            navigationController?.pushViewController(ImageExamplesViewController(), animated: true)
        default:
            break
        }
    }
}
