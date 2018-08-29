//
//  Example9View.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 29/08/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Example9View: UIView {

    private var tableViewContraints = [NSLayoutConstraint]()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Example9TableViewCell", bundle: nil), forCellReuseIdentifier: "Example9TableViewCell")
        tableView.estimatedRowHeight = 44
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        addTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTableView()
    }

    private func addTableView() {
        self.addSubview(tableView)

        tableViewContraints = [
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 200) // You need to setup a fixed Height cause tableView can not calculate it own size.
        ]

        NSLayoutConstraint.activate(tableViewContraints)
    }

}

extension Example9View: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Example9TableViewCell", for: indexPath) as! Example9TableViewCell
        cell.label.text = "Rox \(indexPath.row + 1)"
        return cell
    }
}
