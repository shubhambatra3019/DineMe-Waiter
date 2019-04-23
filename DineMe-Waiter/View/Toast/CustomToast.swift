//
//  CustomToast.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class CustomToast: UIView {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "closeButton")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    init(image: UIImage, description: String, frame: CGRect) {
        super.init(frame: frame)
        imageView.image = image
        descriptionLabel.text = description
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = 15.0
        setupViews()
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(descriptionLabel)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        self.widthAnchor.constraint(equalToConstant: 185).isActive = true
        self.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

