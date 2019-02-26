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
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$00.00"
        label.textAlignment = .left
        return label
    }()
 
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
        itemLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        itemLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        itemLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        itemLabel.heightAnchor.constraint(equalToConstant: 50.0)
        
        /*itemStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        itemStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        itemStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemStackView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true*/
 
    }
    
}
