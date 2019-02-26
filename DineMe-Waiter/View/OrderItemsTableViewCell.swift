//
//  OrderItemsTableViewCell.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 25/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class OrderItemsTableViewCell: UITableViewCell {

    var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "20.0"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        //stackView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }*/
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupViews() {
        cellStack.addArrangedSubview(quantityLabel)
        cellStack.addArrangedSubview(itemNameLabel)
        cellStack.addArrangedSubview(priceLabel)
        addSubview(cellStack)
        
        cellStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        cellStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
}
