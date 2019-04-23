//
//  MenuItemsTableViewCell.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 16/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class MenuItemsTableViewCell: UITableViewCell {
    
    var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /*var descriptionLabel: UILabel = {
     let label = UILabel()
     label.text = "SampleDescription"
     label.textAlignment = .left
     return label
     
     }()
     */
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$00.00"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /*
     var itemStackView: UIStackView {
     let stackView = UIStackView()
     stackView.distribution = .fill
     stackView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
     stackView.axis = .vertical
     stackView.alignment = .leading
     stackView.translatesAutoresizingMaskIntoConstraints = false
     stackView.spacing = 0
     stackView.backgroundColor = UIColor.red
     return stackView
     }*/
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        //itemStackView.addArrangedSubview(itemLabel)
        //itemStackView.addArrangedSubview(descriptionLabel)
        //itemStackView.addArrangedSubview(priceLabel)
        //addSubview(itemStackView)
        addSubview(itemLabel)
        addSubview(priceLabel)
        
        itemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        itemLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -20).isActive = true
        itemLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        
        /*itemStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
         itemStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
         itemStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         itemStackView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true*/
        
    }
    
}
