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

    let data = [OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00)]
    
    lazy var itemsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderItemsTableViewCell.self, forCellReuseIdentifier: cellId)
        var frame = tableView.frame
        frame.size.height = tableView.contentSize.height
        tableView.frame = frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    var summaryStackView = OrderSummaryView(subTotal: "$40.00", tax: "$4.00", tip: "$5.00", total: "$49.00", frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    
    let checkoutButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = UIColor.green
        button.setTitle("Checkout", for: .normal)
        button.titleLabel?.textColor = UIColor.green
        button.titleLabel?.textAlignment = .center
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
        itemsTable.layoutIfNeeded()
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemsTable)
        view.addSubview(summaryStackView)
        view.addSubview(checkoutButton)
        itemsTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        itemsTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemsTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        itemsTable.heightAnchor.constraint(equalToConstant: itemsTable.contentSize.height).isActive = true
        summaryStackView.topAnchor.constraint(equalTo: itemsTable.bottomAnchor, constant: 20).isActive = true
        summaryStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        summaryStackView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        summaryStackView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        checkoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        checkoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func buttonPressed() {
        print("Button was pressed")
    }
    
}

extension TableItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrderItemsTableViewCell
        cell.itemNameLabel.text  = data[indexPath.row].itemName
        cell.quantityLabel.text = String(data[indexPath.row].itemQuantity)
        cell.priceLabel.text = String(format: "%.2f", data[indexPath.row].itemPrice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
