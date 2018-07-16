//
//  BaseViewController.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 15/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        return UITableView()
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addTableView() {
        self.view.addSubview(tableView)
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    func configureTableView() {
        tableView.keyboardDismissMode = .interactive
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "ExampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleTableViewCell")
    }
}
