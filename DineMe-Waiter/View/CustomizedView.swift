//
//  CustomizedStackView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 25/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class CustomizedView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Title"
        label.textAlignment = .right
        
        //label.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        //label.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String, value: String, frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel.text = title
        self.valueLabel.text = value
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        self.heightAnchor.constraint(equalToConstant: 40)
        self.widthAnchor.constraint(equalToConstant: 180)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        valueLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20).isActive = true
        valueLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
}


