//
//  WaiterProfileViewController.swift
//  DineMe-Waiter
//
//  Created by Hritvik JV on 09/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation
import UIKit

class WaiterProfileViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.black
        imageView.image = UIImage(named: "testImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let itemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kamlesh"
        label.font = UIFont(name: "Helvetica-Bold", size: 30.0)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label;
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "kamlesh@notkmalesh.com"
        label.font = UIFont(name: "Helvetica-Bold", size: 15.0)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let logOutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = UIColor.cyan
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24.0)
        button.layer.cornerRadius = 20.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let infoView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = UIColor.white
        view.alignment = .center
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func logOutButtonPressed() {
        //Do something
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        
        itemView.addSubview(nameLabel)
        itemView.addSubview(emailLabel)
        
        infoView.addArrangedSubview(itemView)
        
        view.addSubview(profileImageView)
        view.addSubview(logOutButton)
        view.addSubview(infoView)
        
        NSLayoutConstraint.activate([
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0),
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0),
        profileImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0),
        profileImageView.heightAnchor.constraint(equalToConstant: 200.0),
        
        logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30.0),
        logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
        logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
        logOutButton.heightAnchor.constraint(equalToConstant: 50),
        
        infoView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5.0),
        infoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0),
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0),
        
        nameLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 10.0),
        nameLabel.leftAnchor.constraint(equalTo: itemView.leftAnchor),
        nameLabel.rightAnchor.constraint(equalTo: itemView.rightAnchor),
        
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
        emailLabel.leftAnchor.constraint(equalTo: itemView.leftAnchor),
        emailLabel.rightAnchor.constraint(equalTo: itemView.rightAnchor)
        ])
    }
}


