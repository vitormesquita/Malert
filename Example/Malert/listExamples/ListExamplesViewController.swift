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
    
    private let examples: [ExampleType] = [.withImage, .textField, .customizable, .expandable]
    
    override func loadView() {
        super.loadView()
        addTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Examples"
        navigationController?.navigationBar.barTintColor = .primary
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    override func configureTableView() {
        super.configureTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "ExampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleTableViewCell")
    }
}

extension ListExamplesViewController: UITableViewDelegate, UITableViewDataSource {
    
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
