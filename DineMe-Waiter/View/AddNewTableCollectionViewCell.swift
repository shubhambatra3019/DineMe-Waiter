//
//  AddNewTableCollectionViewCell.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 08/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class AddNewTableCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.backgroundColor = UIColor.green
            }
            else {
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    var peopleLabel: UILabel = {
        let label  = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(peopleLabel)
        peopleLabel.translatesAutoresizingMaskIntoConstraints = false
        peopleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        peopleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        peopleLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        peopleLabel.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        //peopleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4)
        //peopleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4)
    }
    
}
