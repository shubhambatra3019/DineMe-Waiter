//
//  RestaurantViewCell.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Restaurant"
        label.font = UIFont(name: "Helvetica", size: 24.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(restaurantNameLabel)
        
        restaurantNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        restaurantNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        restaurantNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        restaurantNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

