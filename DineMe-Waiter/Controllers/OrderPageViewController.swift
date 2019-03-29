//
//  OrderPageViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 05/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class OrderPageViewController: UIViewController {

    let orderCellId = "orderTableCellId"
    
    let orderHeaderId = "orderTableHeaderId"
    
    var sections = ["Queued", "Ongoing", "Done"]
    
    var orderListener: ListenerRegistration?
    
    var queued = [OrderItem]()
    var ongoing = [OrderItem]()
    var done = [OrderItem]()
    
    var orderID: String!
    
    var table: String!
    
    lazy var orderTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderPageTableViewCell.self, forCellReuseIdentifier: orderCellId)
        tableView.register(OrderTableHeaderView.self, forHeaderFooterViewReuseIdentifier: orderHeaderId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
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
        setupViews()
        
        navigationItem.title = "Table 1"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        //navigationController?.navigationBar.prefersLargeTitles = true
        startListeningForOrder(orderID: orderID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        orderListener?.remove()
        orderListener = nil
    }
    
    func setupViews() {
        view.addSubview(orderTableView)
        view.addSubview(addItemButton)
        view.addSubview(checkoutButton)
        
        orderTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        orderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        orderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        orderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        addItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        addItemButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -40).isActive = true
        addItemButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addItemButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
     }
    
    func classifyItemsByStatus(items: [OrderItem]) {
        self.queued = []
        self.ongoing = []
        self.done = []
        for item in items {
            if item.status == 0 {
                self.queued.append(item)
            }
            else if item.status == 1 {
                self.ongoing.append(item)
            }
            else if item.status == 2{
                self.done.append(item)
            }
            else {
                print("Wrong Status. Something went wrong")
            }
        }
    }
    
    func startListeningForOrder(orderID: String) {
        let query = Firestore.firestore().collection("orders").document(orderID)
        
        orderListener = query.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("Error while fetching items \(error.localizedDescription)")
            }
            guard let snapshot = snapshot else { return }
            
            guard let document = snapshot.data() else { return }
            print("Making a call to firebase!!!!!!!!!!!!!!!!!!")
            let updatedOrder = Order(dict: document)
            
            let orderItems = updatedOrder.items
            
            self.classifyItemsByStatus(items: orderItems)
            
            print(self.queued.count)
            print(self.ongoing.count)
            print(self.done.count)
            
            self.orderTableView.reloadData()
        })
    }
    
    @objc func menuButtonPressed() {
        let menuVC = MenuViewController()
        menuVC.orderID = self.orderID
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    @objc func checkoutButtonPressed() {
        let checkoutPage = CheckoutViewController()
        checkoutPage.table = self.table
        checkoutPage.orderID = self.orderID
        self.navigationController?.pushViewController(checkoutPage, animated: true)
    }
    
    func updateFirebaseItems(items: [OrderItem], orderID: String) {
        
        let query = Firestore.firestore().collection("orders").document(orderID)
        let dictArrayItems = items.map { $0.documentData }
        
        query.updateData(["items": dictArrayItems]) { (error) in
            if let error = error {
                print("Error while update \(error.localizedDescription)")
            }
            else {
                print("Items updated successfully")
            }
        }
    }
    
    @objc func moveToOngoingButtonTapped() {
        
        var updatedOrderItems = [OrderItem]()
        
        for item in self.queued {
            let newItem = OrderItem(itemName: item.itemName, itemQuantity: item.itemQuantity, itemPrice: item.itemPrice, itemNote: "", status: 1)
            updatedOrderItems.append(newItem)
        }
        
        let orderItems = updatedOrderItems + self.ongoing + self.done
        
        updateFirebaseItems(items: orderItems, orderID: orderID)
        
    }
    
    @objc func moveToDoneButtonTapped() {
        var updatedOrderItems = [OrderItem]()
        
        for item in self.ongoing {
            let newItem = OrderItem(itemName: item.itemName, itemQuantity: item.itemQuantity, itemPrice: item.itemPrice, itemNote: "", status: 2)
            updatedOrderItems.append(newItem)
        }
        
        let orderItems = self.queued + updatedOrderItems + self.done
        
        updateFirebaseItems(items: orderItems, orderID: orderID)
    }

    func moveItemToOngoing(indexPath: IndexPath) {
        print(indexPath.row)
        print("Queued: \(self.queued)")
        let oldItem = queued.remove(at: indexPath.row)
        
        let newItem = OrderItem(itemName: oldItem.itemName, itemQuantity: oldItem.itemQuantity, itemPrice: oldItem.itemPrice, itemNote: "", status: 1)
        
        let items = self.queued + [newItem] + self.ongoing + self.done
        
        updateFirebaseItems(items: items, orderID: orderID)
        
    }
    
    func moveItemToDone(indexPath: IndexPath) {
        
        let oldItem = ongoing.remove(at: indexPath.row)
        
        let newItem = OrderItem(itemName: oldItem.itemName, itemQuantity: oldItem.itemQuantity, itemPrice: oldItem.itemPrice, itemNote: "", status: 2)
        
        
        let items = self.queued + self.ongoing + [newItem] + self.done
        
        updateFirebaseItems(items: items, orderID: orderID)
    }
    
}

extension OrderPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: orderHeaderId) as! OrderTableHeaderView
        
        if section == 0 {
            header.titleLabel.text = sections[section]
            header.moveItemsButton.setTitle("Move All to Ongoing", for: .normal)
            header.moveItemsButton.addTarget(self, action: #selector(moveToOngoingButtonTapped), for: .touchUpInside)
            header.moveItemsButton.isHidden = false
        }
        if section == 1 {
            header.titleLabel.text = sections[section]
            header.moveItemsButton.setTitle("Move All to Done", for: .normal)
            header.moveItemsButton.addTarget(self, action: #selector(moveToDoneButtonTapped), for: .touchUpInside)
        }
        if section == 2 {
            header.titleLabel.text = sections[section]
            header.moveItemsButton.isHidden = true
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return queued.count
        }
        if section == 1 {
            return ongoing.count
        }
        else {
            return done.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: orderCellId, for: indexPath) as! OrderPageTableViewCell
        
        if indexPath.section == 0 {
            cell.quantityLabel.text = String(queued[indexPath.row].itemQuantity)
            cell.itemNameLabel.text = queued[indexPath.row].itemName
        }
        
        if indexPath.section == 1 {
            cell.quantityLabel.text = String(ongoing[indexPath.row].itemQuantity)
            cell.itemNameLabel.text = ongoing[indexPath.row].itemName
        }
        
        if indexPath.section == 2 {
            cell.quantityLabel.text = String(done[indexPath.row].itemQuantity)
            cell.itemNameLabel.text = done[indexPath.row].itemName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 0 {
            let moveToOngoingAction = UIContextualAction(style: .destructive, title: "Move To Ongoing") { (action, view, handler) in
                print(indexPath.row)
                self.moveItemToOngoing(indexPath: indexPath)
            }
            moveToOngoingAction.backgroundColor = .green
            let configuration = UISwipeActionsConfiguration(actions: [moveToOngoingAction])
            configuration.performsFirstActionWithFullSwipe = true
            return configuration
        }
        if indexPath.section == 1 {
            let moveToDoneAction = UIContextualAction(style: .destructive, title: "Move To Done") { (action, view, handler) in
                print(indexPath.row)
                self.moveItemToDone(indexPath: indexPath)
            }
            moveToDoneAction.backgroundColor = .green
            let configuration = UISwipeActionsConfiguration(actions: [moveToDoneAction])
            configuration.performsFirstActionWithFullSwipe = true
            return configuration
        }
        let configuration = UISwipeActionsConfiguration(actions: [])
        return configuration
    }
    
}
