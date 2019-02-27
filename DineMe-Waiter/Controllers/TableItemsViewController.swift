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
        tableView.isScrollEnabled = true
        tableView.bounces = true
        
        return tableView
    }()
    
    let itemsView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
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
        setupViews()
        self.navigationItem.title = "Table1"
        scrollView.delegate = self
        //let screenHeight = UIScreen.main.bounds.height
        // Do any additional setup after loading the view.
    }
    
    
    func setupViews() {
        let navigationHeight = self.navigationController?.navigationBar.frame.height
        let tableHeight = data.count * 60
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemsView)
        itemsView.addSubview(scrollView)
        itemsView.addSubview(itemsTable)
        itemsView.addSubview(summaryStackView)
        view.addSubview(checkoutButton)
        
        itemsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        itemsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        itemsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemsView.heightAnchor.constraint(equalToConstant: CGFloat(tableHeight)).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: itemsView.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: itemsView.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: itemsView.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: itemsView.bottomAnchor).isActive = true
        
        itemsTable.leftAnchor.constraint(equalTo: itemsView.leftAnchor).isActive = true
        itemsTable.rightAnchor.constraint(equalTo: itemsView.rightAnchor).isActive = true
        itemsTable.topAnchor.constraint(equalTo: itemsView.topAnchor).isActive = true
        itemsTable.heightAnchor.constraint(equalToConstant: CGFloat(tableHeight)).isActive = true
        
        summaryStackView.topAnchor.constraint(equalTo: itemsTable.bottomAnchor, constant: 20).isActive = true
        summaryStackView.rightAnchor.constraint(equalTo: itemsView.rightAnchor, constant: 0).isActive = true
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

/*extension TableItemsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let screenHeight = UIScreen.main.bounds.height
        let scrollViewContentHeight = CGFloat((data.count * 60) + 200)
        if scrollView == self.itemsTable {
            if yOffset >= scrollViewContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
                itemsTable.isScrollEnabled = true
            }
        }
        
        if scrollView == self.scrollView {
            if yOffset <= 0 {
                self.scrollView.isScrollEnabled = true
                self.itemsTable.isScrollEnabled = false
            }
        }
    }
}*/
