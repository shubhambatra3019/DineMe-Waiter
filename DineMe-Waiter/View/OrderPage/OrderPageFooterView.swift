//
//  OrderPageFooterView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class OrderPageFooterView: UITableViewHeaderFooterView {
    
    var footerTextLabel: UILabel = {
        
        let label = UILabel()
        label.text = "No Items To Show"
        label.textAlignment = .center
        label.font = UIFont.fontAwesome(ofSize: 20.0, style: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(footerTextLabel)
        footerTextLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        footerTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        footerTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        footerTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

