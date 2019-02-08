//
//  OngoingTableViewCell.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 02/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class OngoingTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    var tableLabel: UILabel = {
        let label = UILabel()
        label.text = "Table1"
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupViews() {
        addSubview(tableLabel)
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        //tableLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5)
        //tableLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        tableLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        tableLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        
    }
}
