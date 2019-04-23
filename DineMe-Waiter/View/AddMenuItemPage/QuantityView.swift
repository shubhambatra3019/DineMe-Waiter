//
//  CustomPopupView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 27/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class QuantityView: UIView {
    
    var quantity: Int = 0 {
        didSet {
            quantityLabel.text = String(quantity)
            self.enableButtons(quantity: self.quantity)
        }
    }
    
    let decreaseQuantityButton: UIButton = {
        let button = UIButton()
        let minusImage = UIImage.fontAwesomeIcon(name: .minusCircle, style: .solid, textColor: UIColor.green, size: CGSize(width: 50, height: 50))
        button.setImage(minusImage, for: .normal)
        button.addTarget(self, action: #selector(decreaseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let increaseQuantityButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage.fontAwesomeIcon(name: .plusCircle, style: .solid, textColor: UIColor.green, size: CGSize(width: 50, height: 50))
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(increaseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        return label
    }()
    
    let quantityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func decreaseButtonPressed() {
        
        self.quantity -= 1
        
    }
    
    func enableButtons(quantity: Int) {
        if self.quantity == 1 {
            self.decreaseQuantityButton.isEnabled = false
        }
        else {
            self.decreaseQuantityButton.isEnabled = true
        }
        
        if self.quantity == 10 {
            self.increaseQuantityButton.isEnabled = false
        }
        else {
            self.increaseQuantityButton.isEnabled = true
        }
    }
    
    @objc private func increaseButtonPressed() {
        self.quantity += 1
    }
    
    func setupViews() {
        quantityStackView.addArrangedSubview(decreaseQuantityButton)
        quantityStackView.addArrangedSubview(quantityLabel)
        quantityStackView.addArrangedSubview(increaseQuantityButton)
        addSubview(quantityStackView)
        
        quantityStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        quantityStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        quantityStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        quantityStackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
}

