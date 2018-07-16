//
//  ImageExamplesViewController.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 15/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Malert

/*
 Image + title + description
 Image + title
 Image + description
 Image
 */

class ImageExamplesViewController: BaseViewController {
    
    override func loadView() {
        super.loadView()
        addTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Malert with images"
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .imageExample
    }
    
    override func configureTableView() {
        super.configureTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
    }
    
    private func showMalert() {
        let firsExample = FirstCustomView.instantiateFromNib()
        
        let alert = Malert(customView: firsExample)
        alert.addAction(MalertAction(title: "OK", actionBlock: {
            print("chamou cuzao")
        }))
    
        present(alert, animated: true)
    }
}

extension ImageExamplesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showMalert()
    }
}
