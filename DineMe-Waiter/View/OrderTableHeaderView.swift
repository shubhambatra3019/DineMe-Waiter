//
//  OrderTableHeaderView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 06/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class OrderTableHeaderView: UITableViewHeaderFooterView {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Queued"
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var moveItemsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move All to Ongoing", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.green
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(titleLabel)
        addSubview(moveItemsButton)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100)
        
        moveItemsButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        moveItemsButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        moveItemsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        moveItemsButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    
}
