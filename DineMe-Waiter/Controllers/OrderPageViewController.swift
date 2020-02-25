//
//  OrderPageViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 05/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FontAwesome_swift

class OrderPageViewController: UIViewController {
    
    let orderCellId = "orderTableCellId"
    let orderHeaderId = "orderTableHeaderId"
    let orderFooterId = "orderTableFooterId"
    var sections = ["Queued", "Ongoing", "Done"]
    var orderListener: ListenerRegistration?
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var orderedItems = [[OrderItem](), [OrderItem](), [OrderItem]()]
    var orderID: String!
    var restaurantID: String!
    let blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
    
    lazy var blurEffectView = UIVisualEffectView(effect: blur)
    
    lazy var orderTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderPageTableViewCell.self, forCellReuseIdentifier: orderCellId)
        tableView.register(OrderTableHeaderView.self, forHeaderFooterViewReuseIdentifier: orderHeaderId)
        tableView.register(OrderPageFooterView.self, forHeaderFooterViewReuseIdentifier: orderFooterId)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 60.0
        tableView.layer.zPosition = 0
        tableView.rowHeight = UITableView.automaticDimension
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.contentInset = insets
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
        button.layer.zPosition = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let noItemsImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "order_empty"))
        imageView.isHidden = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let itemUpdatedToast: CustomToast = {
        let image = UIImage.fontAwesomeIcon(name: .checkCircle, style: .solid, textColor: UIColor.green, size: CGSize(width: 50, height: 50))
        let toast = CustomToast(image: image, description: "Successfully Updated", frame: CGRect.zero)
        
        return toast
    }()
    
    let itemDeletedToast: CustomToast = {
        let image = UIImage.fontAwesomeIcon(name: .trash, style: .solid, textColor: UIColor.red, size: CGSize(width: 50, height: 50))
        let toast = CustomToast(image: image, description: "Successfully Deleted", frame: CGRect.zero)
        return toast
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        navigationItem.title = "Table 1"
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(toggleTableViewEditing))
        self.navigationItem.rightBarButtonItem = editButton
        
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
        view.addSubview(noItemsImageView)
        
        NSLayoutConstraint.activate([
        orderTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        orderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        orderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        orderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        addItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        addItemButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -40),
        addItemButton.widthAnchor.constraint(equalToConstant: 150),
        addItemButton.heightAnchor.constraint(equalToConstant: 50),
        
        checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        checkoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func classifyItemsByStatus(items: [OrderItem]) {
        orderedItems = []
        var queued = [OrderItem]()
        var ongoing = [OrderItem]()
        var done = [OrderItem]()
        for item in items {
            if item.status == 0 {
                queued.append(item)
            }
            else if item.status == 1 {
                ongoing.append(item)
            }
            else if item.status == 2{
                done.append(item)
            }
            else {
                print("Wrong Status. Something went wrong")
            }
        }
        orderedItems = [queued, ongoing, done]
        print(orderedItems)
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
            
            self.orderTableView.reloadData()
            
        })
    }
    
    @objc func menuButtonPressed() {
        let menuVC = MenuViewController()
        menuVC.orderID = self.orderID
        menuVC.restaurantID = restaurantID
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    @objc func toggleTableViewEditing() {
        self.orderTableView.setEditing(!self.orderTableView.isEditing, animated: true)
        
        self.navigationItem.rightBarButtonItem?.title = (self.orderTableView.isEditing) ? "Done" : "Edit"
    }
    
    @objc func checkoutButtonPressed() {
        let checkoutPage = CheckoutViewController()
         checkoutPage.orderID = self.orderID
        checkoutPage.restaurantID = restaurantID
         self.navigationController?.pushViewController(checkoutPage, animated: true)
    }
    
    func updateFirebaseItems(items: [OrderItem], orderID: String) {
        
        let query = Firestore.firestore().collection("orders").document(orderID)
        let dictArrayItems = items.map { $0.documentData }
        
        query.updateData(["items": dictArrayItems]) { (error) in
            if let error = error {
                print("Error while update \(error.localizedDescription)")
                return
            }
            else {
                print("Items updated successfully")
                
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleDeleteItem(indexPath: IndexPath) {
        
        self.orderedItems[indexPath.section].remove(at: indexPath.row)
        
        var items = [OrderItem]()
        for elem in orderedItems {
            items += elem
        }
        print(items)
        updateFirebaseItems(items: items, orderID: orderID)
        self.showToast(toastView: itemDeletedToast)
    }
    
    @objc func moveToOngoingButtonTapped() {
     
        var updatedOrderItems = [OrderItem]()
     
        for item in self.orderedItems[0] {
            let newItem = OrderItem(itemName: item.itemName, itemQuantity: item.itemQuantity, itemPrice: item.itemPrice, itemNote: "", status: 1)
            updatedOrderItems.append(newItem)
        }
     
        let orderItems = updatedOrderItems + self.orderedItems[1] + self.orderedItems[2]
     
        updateFirebaseItems(items: orderItems, orderID: orderID)
     
    }
    
    @objc func moveToDoneButtonTapped() {
        var updatedOrderItems = [OrderItem]()
     
        for item in self.orderedItems[1] {
            let newItem = OrderItem(itemName: item.itemName, itemQuantity: item.itemQuantity, itemPrice: item.itemPrice, itemNote: "", status: 2)
            updatedOrderItems.append(newItem)
        }
     
        let orderItems = self.orderedItems[0] + updatedOrderItems + self.orderedItems[2]
     
        updateFirebaseItems(items: orderItems, orderID: orderID)
     }
    
    func moveItemToOngoing(indexPath: IndexPath) {
     
        let oldItem = self.orderedItems[indexPath.section].remove(at: indexPath.row)
     
        let newItem = OrderItem(itemName: oldItem.itemName, itemQuantity: oldItem.itemQuantity, itemPrice: oldItem.itemPrice, itemNote: "", status: 1)
     
        let items = self.orderedItems[0] + [newItem] + self.orderedItems[1] + self.orderedItems[2]
     
        updateFirebaseItems(items: items, orderID: orderID)
     
     }
    
    func moveItemToDone(indexPath: IndexPath) {
     
        let oldItem = self.orderedItems[indexPath.section].remove(at: indexPath.row)
     
        let newItem = OrderItem(itemName: oldItem.itemName, itemQuantity: oldItem.itemQuantity, itemPrice: oldItem.itemPrice, itemNote: "", status: 2)
     
        let items = self.orderedItems[0] + self.orderedItems[1] + [newItem] + self.orderedItems[2]
     
        updateFirebaseItems(items: items, orderID: orderID)
    }
    
}

extension OrderPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: orderFooterId) as! OrderPageFooterView
        footer.footerTextLabel.text = "No Items in \(sections[section])"
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if orderedItems[section].count == 0 {
            return 40.0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderedItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: orderCellId, for: indexPath) as! OrderPageTableViewCell
        
        cell.quantityLabel.text = String(orderedItems[indexPath.section][indexPath.row].itemQuantity)
        cell.itemNameLabel.text = orderedItems[indexPath.section][indexPath.row].itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteTable = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.handleDeleteItem(indexPath: indexPath)
        }
        
        return [deleteTable]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        
        let item = orderedItems[indexPath.section][indexPath.row]
        
        let addItemViewController = AddItemViewController()
        addItemViewController.orderItem = item
        addItemViewController.addItemModal.addItemButton.setTitle("Update", for: .normal)
        addItemViewController.delegate = self
        addItemViewController.modalPresentationStyle = .overCurrentContext
        
        present(addItemViewController, animated: true, completion: nil)
        
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.9
        view.addSubview(blurEffectView)
        
        
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

extension OrderPageViewController: AddItemViewDelegate {
    func addItem(orderItem: OrderItem) {
        
        var orderItem = orderItem
        
        let oldItem = orderedItems[selectedIndexPath.section][selectedIndexPath.row]
        
        if oldItem.itemQuantity != orderItem.itemQuantity {
            orderItem.status = oldItem.status
            orderedItems[selectedIndexPath.section][selectedIndexPath.row] = orderItem
            
            var items = [OrderItem]()
            for elem in orderedItems {
                items += elem
            }
            updateFirebaseItems(items: items, orderID: orderID)
            blurEffectView.removeFromSuperview()
            self.showToast(toastView: self.itemUpdatedToast)
        }
        else {
            self.dismiss(animated: true, completion: nil)
            blurEffectView.removeFromSuperview()
        }
        
    }
    
    func dismissController(controller: UIViewController) {
        blurEffectView.removeFromSuperview()
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
