//
//  OrderPageViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 05/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class OrderPageViewController: UIViewController {

    let orderCellId = "orderTableCellId"
    
    let orderHeaderId = "orderTableHeaderId"
    
    var sections = ["Queued", "Ongoing", "Done"]
    
    var queued:[OrderItem] = [OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "AbCD", itemQuantity: 3, itemPrice: 14.00), OrderItem(itemName: "EFGH", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "IJKL", itemQuantity: 5, itemPrice: 14.00), OrderItem(itemName: "MNOP", itemQuantity: 6, itemPrice: 14.00)]
    
    var ongoing = [OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00)]
    
    var done = [OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00),OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "Naan", itemQuantity: 4, itemPrice: 14.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00), OrderItem(itemName: "ButterChicken", itemQuantity: 2, itemPrice: 20.00)]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
        
        
    }
    
    func setupViews() {
        view.addSubview(orderTableView)
        orderTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        orderTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        orderTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        orderTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
     }
    
    @objc func moveToOngoingButtonTapped() {
        let temp = queued
        queued.removeAll()
        ongoing.insert(contentsOf: temp, at: 0)
        print(ongoing)
        orderTableView.reloadData()
    }
    
    @objc func moveToDoneButtonTapped() {
        let temp = ongoing
        ongoing.removeAll()
        done.insert(contentsOf: temp, at: 0)
        orderTableView.reloadData()
    }

    func moveItemToOngoing(indexPath: IndexPath) {
        let item = queued.remove(at: indexPath.row)
        print(item.itemName)
        
        ongoing.insert(item, at: 0)
        orderTableView.reloadData()
    }
    
    func moveItemToDone(indexPath: IndexPath) {
        let item = ongoing.remove(at: indexPath.row)
        print(item.itemName)
        
        done.insert(item, at: 0)
        orderTableView.reloadData()
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
