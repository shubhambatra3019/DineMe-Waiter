//
//  CustomPopupView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 27/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class QuantityChangeView: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var quantity: Int = 0
    
    let decreaseQuantityButton: UIButton = {
       let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30.0)
        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(decreaseButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let increaseQuantityButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.orange
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        button.addTarget(self, action: #selector(increaseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.textColor = UIColor.orange
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
        quantity = 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func decreaseButtonPressed() {
        self.quantity -= 1
        if self.quantity == 1 {
            self.decreaseQuantityButton.isEnabled = false
        }
        if self.quantity == 9 {
            self.increaseQuantityButton.isEnabled = true
        }
        self.quantityLabel.text = String(self.quantity)
    }
    
    @objc private func increaseButtonPressed() {
        self.quantity += 1
        if self.quantity == 2 {
            self.decreaseQuantityButton.isEnabled = true
        }
        if self.quantity == 10 {
            self.increaseQuantityButton.isEnabled = false
        }
        self.quantityLabel.text = String(self.quantity)
    }
    
    func setupViews() {
        quantityStackView.addArrangedSubview(decreaseQuantityButton)
        quantityStackView.addArrangedSubview(quantityLabel)
        quantityStackView.addArrangedSubview(increaseQuantityButton)
        addSubview(quantityStackView)
        
        quantityStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        quantityStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        quantityStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        quantityStackView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
}
