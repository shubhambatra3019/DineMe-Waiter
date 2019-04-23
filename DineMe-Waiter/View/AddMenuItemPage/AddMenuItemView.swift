//
//  AddMenuItemView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class AddMenuItemView: UIView {
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Label"
        label.font = UIFont(name: "Helvetica-Bold", size: 22.0)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.green
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10.0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var quantityView: QuantityView = {
        let view = QuantityView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.text = "Add a note for the kitchen..."
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: "Helvetica", size: 20.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let addItemButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Item", for: .normal)
        button.backgroundColor = UIColor.green
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = UIColor.red
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    //var delegate: AddMenuItemViewDelegate?
    
    init(itemName: String, itemQuantity: Int = 1, itemNote: String = "", buttonTitle: String, frame: CGRect) {
        super.init(frame: frame)
        
        itemNameLabel.text = itemName
        quantityView.quantity = itemQuantity
        noteTextView.text = itemNote
        addItemButton.setTitle(buttonTitle, for: .normal)
        noteTextView.delegate = self
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10.0
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(itemNameLabel)
        self.addSubview(quantityView)
        self.addSubview(noteTextView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(addItemButton)
        self.addSubview(buttonStackView)
        
        itemNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        itemNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        quantityView.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 15).isActive = true
        quantityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        quantityView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        quantityView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        noteTextView.topAnchor.constraint(equalTo: quantityView.bottomAnchor, constant: 15).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        buttonStackView.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 20).isActive = true
        buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonStackView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        
        
    }
    
}

/*protocol AddMenuItemViewDelegate {
 func buttonPressed()
 }*/

extension AddMenuItemView: UITextViewDelegate {
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
