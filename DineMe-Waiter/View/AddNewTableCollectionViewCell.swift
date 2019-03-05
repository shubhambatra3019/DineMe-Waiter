//
//  AddNewTabeCollectionViewCell.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 01/03/19.
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
                self.backgroundColor = UIColor.gray
            }
        }
    }
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
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
        addSubview(numberLabel)
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 4
        self.heightAnchor.constraint(equalToConstant: 30)
        self.widthAnchor.constraint(equalToConstant: 30)
        numberLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        numberLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        numberLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    
}
