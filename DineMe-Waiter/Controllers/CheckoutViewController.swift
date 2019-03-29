//
//  TableItemsViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 25/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CheckoutViewController: UIViewController {

    let cellId = "orderItemsCell"

    let cellId2 = "summaryCell"
    
    var orderID: String = ""
    
    var tableItemsListener: ListenerRegistration?
    
    var orderItems = [OrderItem]()
    
    let userData = User(dict: UserDefaults.standard.dictionary(forKey: "user")!)
    
    var table: String = ""
    
    lazy var itemsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderItemsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(OrderedItemsSummaryTableViewCell.self, forCellReuseIdentifier: cellId2)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        setupViews()
    
        navigationItem.title = "Cheque"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItemsForTableFromFirebase(orderID: orderID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableItemsListener?.remove()
        tableItemsListener = nil
    }
    
    func getItemsForTableFromFirebase(orderID: String) {
        let query = Firestore.firestore().collection("orders").document(orderID)
        
        tableItemsListener = query.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("Error while fetching items \(error.localizedDescription)")
            }
            guard let snapshot = snapshot else { return }
            var updatedItems = [OrderItem]()
            var document = snapshot.data()
            let items = document!["items"] as! [[String: Any]]
            self.table = document!["table"] as! String
            for item in items {
                let orderItem = OrderItem(dict: item)
                updatedItems.append(orderItem)
            }
            self.orderItems = updatedItems
            self.itemsTable.reloadData()
        })
    }
    
    func setupViews() {
        
        view.addSubview(itemsTable)
        view.addSubview(checkoutButton)
        
        itemsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        itemsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        itemsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        itemsTable.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor).isActive = true
        
        checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func checkoutButtonPressed() {
        let query = Firestore.firestore().collection("orders").document(orderID)
        
        let queryRestuarnts = Firestore.firestore().collection("restaurants").document((userData?.restaurants[0])!)
        
        query.updateData(["completed": true, "paidDateTime": Date()]) { (error) in
            if let error = error {
                print("Error updating document \(error.localizedDescription)")
            }
            else {
                print("Document Successfully updated")
            }
        }
        
        queryRestuarnts.updateData(["Tables.\(table).available": true]) { (error) in
            if let error = error {
                print("Error while updating \(error.localizedDescription)")
            }
            else {
                print("Document Updated Successfully")
            }
        }
        //let ongoingTableVC = OngoingTablesViewController()
    
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: OngoingTablesViewController.self) {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                
                break
            }
        }
    }
    
    func calcualteSubtotal(orderItems: [OrderItem]) -> Double {
        var subtotal = 0.0
        for item in orderItems {
            let price = Double(item.itemQuantity) * item.itemPrice
            subtotal += price
        }
        return subtotal
    }
    
}

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (orderItems.count+1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == orderItems.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId2, for: indexPath) as! OrderedItemsSummaryTableViewCell
            let subtotal = calcualteSubtotal(orderItems: self.orderItems)
            let tip = 4.00
            let tax = 5.00
            
            cell.summaryView.subtotalView.valueLabel.text = String(format: "%.2f", subtotal)
            cell.summaryView.taxView.valueLabel.text = String(tax)
            cell.summaryView.tipView.valueLabel.text = String(tip)
            cell.summaryView.totalView.valueLabel.text = String(subtotal + tax + tip)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrderItemsTableViewCell
            cell.itemNameLabel.text  = orderItems[indexPath.row].itemName
            cell.quantityLabel.text = String(orderItems[indexPath.row].itemQuantity)
            cell.priceLabel.text = String(format: "%.2f", (Double(orderItems[indexPath.row].itemQuantity) * orderItems[indexPath.row].itemPrice))
            return cell
        }
        
    }
}
