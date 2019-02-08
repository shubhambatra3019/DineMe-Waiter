//
//  OngoingTablesViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 01/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit


class OngoingTablesViewController: UIViewController {
    
    let tables = ["Table1", "Table2", "Table3"]
    let cellId = "cellID"
    
    lazy var ongoingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OngoingTableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    func setupView() {
        view.addSubview(ongoingTableView)
        ongoingTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ongoingTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ongoingTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        ongoingTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        ongoingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        ongoingTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Ongoing Tables"
        setupView()
        ongoingTableView.delegate = self
        ongoingTableView.dataSource = self
    }
    
}

extension OngoingTablesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OngoingTableViewCell
        cell.tableLabel.text = tables[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}



