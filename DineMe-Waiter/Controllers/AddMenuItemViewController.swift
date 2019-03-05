//
//  AddMenuItemViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 01/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class AddMenuItemViewController: UIViewController {

    let itemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Butter Chicken"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = UIColor.white
        noteTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @objc func addButtonPressed() {
        print("Button pressed")
    }
    
    func setupViews() {
        itemView.addSubview(itemNameLabel)
        view.addSubview(itemView)
        view.addSubview(quantityView)
        view.addSubview(noteTextView)
        view.addSubview(addItemButton)
        itemView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        itemView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        itemView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemNameLabel.leftAnchor.constraint(equalTo: itemView.leftAnchor, constant: 30).isActive = true
        itemNameLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 40).isActive = true
        itemNameLabel.rightAnchor.constraint(equalTo: itemView.rightAnchor).isActive = true
        itemNameLabel.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -40).isActive = true
        
        quantityView.topAnchor.constraint(equalTo: itemView.bottomAnchor, constant: 40).isActive = true
        quantityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quantityView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        quantityView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        noteTextView.topAnchor.constraint(equalTo: quantityView.bottomAnchor, constant: 40).isActive =  true
        noteTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        noteTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addItemButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        addItemButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        addItemButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        addItemButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
            textView.text = "Add a not for the kitchen..."
            textView.textColor = UIColor.lightGray
        }
    }
}