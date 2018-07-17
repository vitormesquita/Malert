//
//  ListExamplesViewController.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 15/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Malert

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
    
    private func showExample1() {
        let firstExample = FirstCustomView.instantiateFromNib()
        firstExample.populate(title: "Hello!", message: "There are a lot of ways to build a Malert :)")

        let alert = Malert(customView: firstExample)
        
        let action = MalertAction(title: "OK")
        action.tintColor = UIColor(red:0.15, green:0.64, blue:0.85, alpha:1.0)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    private func showExample2() {
        let example2View = Example2View.instantiateFromNib()
        
        let alert = Malert(customView: example2View)
        alert.animationType = .modalLeft
        alert.backgroundColor = UIColor(red:0.47, green:0.53, blue:0.80, alpha:1.0)
        alert.buttonsAxis = .horizontal
        alert.buttonsHeight = 60
        alert.separetorColor = .clear
        
        let buttonsColor = UIColor(red:0.36, green:0.42, blue:0.75, alpha:1.0)
        
        let firstAction = MalertAction(title: "GOT IT", backgroundColor: buttonsColor)
        firstAction.tintColor = .white
        alert.addAction(firstAction)
        
        let secondAction = MalertAction(title: "LOOK UP", backgroundColor: buttonsColor)
        secondAction.tintColor = .white
        alert.addAction(secondAction)
        
        present(alert, animated: true)
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
        tableView.deselectRow(at: indexPath, animated: false)
        
        let type = examples[indexPath.row]
        
        switch type {
        case .withImage:
            showExample1()
        case .textField:
            showExample2()
        default:
            break
        }
    }
}
