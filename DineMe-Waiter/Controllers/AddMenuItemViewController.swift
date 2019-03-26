//
//  AddMenuItemViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 01/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AddMenuItemViewController: UIViewController {

    let itemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.font = UIFont(name: "Helvetica-Bold", size: 30.0)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quantityView: QuantityChangeView = {
        let view = QuantityChangeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.text = "Add a not for the kitchen..."
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: "Helvetica", size: 20.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let addItemButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        button.setTitle("Add Item", for: .normal)
        button.backgroundColor = UIColor.orange
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var menuItem = MenuItem(dict: [:]) {
        didSet {
            itemNameLabel.text = menuItem.name
        }
    }
    
    var orderID: String = "DfuwfBvopfGJTtSl4jw1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = UIColor.white
        noteTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @objc func addButtonPressed() {
        let itemToAdd = OrderItem(itemName: menuItem.name!, itemQuantity: Int(quantityView.quantityLabel.text!)!, itemPrice: menuItem.price!, status: 0)
        addItemToFirebase(orderID: orderID, orderItem: itemToAdd)
    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        view.addSubview(closeButton)
        itemView.addSubview(itemNameLabel)
        view.addSubview(itemView)
        view.addSubview(quantityView)
        view.addSubview(noteTextView)
        view.addSubview(addItemButton)
        
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        itemView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20).isActive = true
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        itemNameLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 40).isActive = true
        itemNameLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 30).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor).isActive = true
        itemNameLabel.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -40).isActive = true
        
        quantityView.topAnchor.constraint(equalTo: itemView.bottomAnchor, constant: 40).isActive = true
        quantityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quantityView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        quantityView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        noteTextView.topAnchor.constraint(equalTo: quantityView.bottomAnchor, constant: 40).isActive =  true
        noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addItemButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addItemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addItemButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func addItemToFirebase(orderID: String, orderItem: OrderItem) {
        
        let query = Firestore.firestore().collection("orders").document(orderID)
        
        query.updateData(["items": FieldValue.arrayUnion([orderItem.documentData])]) { (error) in
            if let error = error {
                print("Error while adding \(error.localizedDescription)")
            }
            else {
                print("Item Added Successfully")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}

extension AddMenuItemViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add a note for the kitchen..."
            textView.textColor = UIColor.lightGray
        }
    }
}
