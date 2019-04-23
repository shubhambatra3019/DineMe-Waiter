//
//  InvitesTableViewCell.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class InvitesTableViewCell: UITableViewCell {
    
    var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Restaurant"
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonStackView: ButtonStackView = {
        let buttonStackView = ButtonStackView(frame: CGRect.zero)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(restaurantLabel)
        addSubview(buttonStackView)
        
        restaurantLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        restaurantLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        restaurantLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        restaurantLabel.trailingAnchor.constraint(equalTo: buttonStackView.leadingAnchor).isActive = true
        
        buttonStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        buttonStackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

