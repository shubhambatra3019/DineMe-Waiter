//
//  ButtonStackView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ButtonStackView: UIView {
    
    override var tag: Int {
        didSet {
            acceptButton.tag = self.tag
            rejectButton.tag = self.tag
        }
    }
    
    var acceptButton: UIButton = {
        let button = UIButton()
        let image = UIImage.fontAwesomeIcon(name: .check, style: .solid, textColor: UIColor.white, size: CGSize(width: 40, height: 40))
        //button.setTitle("Accept", for: .normal)
        //button.titleLabel?.textColor = UIColor.white
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor.green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var rejectButton: UIButton = {
        let button = UIButton()
        let image = UIImage.fontAwesomeIcon(name: .times, style: .solid, textColor: UIColor.white, size: CGSize(width: 40, height: 40))
        button.setImage(image, for: .normal)
        //button.setTitle("Reject", for: .normal)
        //button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        buttonStackView.addArrangedSubview(acceptButton)
        buttonStackView.addArrangedSubview(rejectButton)
        addSubview(buttonStackView)
        
        buttonStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
}

