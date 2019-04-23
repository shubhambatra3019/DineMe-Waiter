//
//  AddMenuItemViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 01/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    var orderItem: OrderItem!
    
    var delegate: AddItemViewDelegate?
    
    lazy var addItemModal: AddMenuItemView = {
        let addItemView = AddMenuItemView(itemName: self.orderItem.itemName, itemQuantity: self.orderItem.itemQuantity, itemNote: self.orderItem.itemNote, buttonTitle: "Add Item", frame: CGRect.zero)
        addItemView.translatesAutoresizingMaskIntoConstraints = false
        addItemView.addItemButton.addTarget(self, action: #selector(addItemButtonPressed), for: .touchUpInside)
        addItemView.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return addItemView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        self.view.addSubview(addItemModal)
        
        addItemModal.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        addItemModal.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addItemModal.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc func addItemButtonPressed() {
        print("Will call delegate now")
        let itemToAdd = OrderItem(itemName: orderItem.itemName, itemQuantity: addItemModal.quantityView.quantity, itemPrice: orderItem.itemPrice, itemNote: addItemModal.noteTextView.text, status: 0)
        self.delegate?.addItem(orderItem: itemToAdd)
    }
    
    @objc func cancelButtonPressed() {
        print("Cancel Button Pressed")
        self.delegate?.dismissController(controller: self)
    }
    
}

protocol AddItemViewDelegate {
    func addItem(orderItem: OrderItem)
    func dismissController(controller: UIViewController)
}
