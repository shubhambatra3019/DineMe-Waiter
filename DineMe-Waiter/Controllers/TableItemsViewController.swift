//
//  TableItemsViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 25/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class TableItemsViewController: UIViewController {

    let cellId = "orderItemsCell"

    let cellId2 = "summaryCell"
    
    let data = [OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00)]
    
    lazy var itemsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderItemsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(OrderedItemsSummaryTableViewCell.self, forCellReuseIdentifier: cellId2)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    
    let checkoutButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.addTarget(self, action: #selector(checkoutButtonPressed), for: .touchUpInside)
        button.backgroundColor = UIColor.green
        button.setTitle("Checkout", for: .normal)
        button.titleLabel?.textColor = UIColor.green
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addItemButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        button.backgroundColor = UIColor.purple
        button.setTitle("Add Items", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 25.0
        button.layer.zPosition = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        setupViews()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupViews() {
        
        view.addSubview(itemsTable)
        view.addSubview(checkoutButton)
        view.addSubview(addItemButton)
        itemsTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        itemsTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemsTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        itemsTable.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor).isActive = true
        
        checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        checkoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        checkoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addItemButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -40).isActive = true
        addItemButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        addItemButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addItemButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func checkoutButtonPressed() {
        print("Button was Pressed")
    }
    
    @objc func menuButtonPressed() {
        print("Menu Button was Pressed")
    }
    
}

extension TableItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data.count+1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == data.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId2, for: indexPath) as! OrderedItemsSummaryTableViewCell
            cell.summaryView.subtotalView.valueLabel.text = "$40.00"
            cell.summaryView.taxView.valueLabel.text = "$4.00"
            cell.summaryView.tipView.valueLabel.text = "$5.00"
            cell.summaryView.totalView.valueLabel.text = "$50.00"
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrderItemsTableViewCell
            cell.itemNameLabel.text  = data[indexPath.row].itemName
            cell.quantityLabel.text = String(data[indexPath.row].itemQuantity)
            cell.priceLabel.text = String(format: "%.2f", data[indexPath.row].itemPrice)
            return cell
        }
        
    }
}
