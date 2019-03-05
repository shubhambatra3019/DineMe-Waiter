//
//  CollectionViewHeaderView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 05/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Size"
        label.font = UIFont(name: "Helvetica-Bold", size: 24.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        setupViews()
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
