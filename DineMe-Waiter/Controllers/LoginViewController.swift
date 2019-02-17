//
//  ViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 01/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class LoginViewController: UIViewController {
    
    let dineInLabel : UILabel = {
        let label = UILabel()
        label.text = "Dine In"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let signupButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }
    
    func setupUI(){
        let emptyUIView = UIView()
        let stackView = UIStackView(arrangedSubviews: [dineInLabel,emptyUIView,loginButton, signupButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 50
        
        view.addSubview(stackView)
        
        //StackView Cosntraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
    }
    
    @objc func handleLogin(){
        if let authUI = FUIAuth.defaultAuthUI(){
            authUI.delegate = self
            let providers: [FUIAuthProvider] = [FUIEmailAuth(),FUIGoogleAuth()]
            authUI.providers = providers
            let authVC = authUI.authViewController()
            present(authVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func handleSignup(){
        
    }
}

extension LoginViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error != nil else{
            print(error?.localizedDescription)
            return
        }
        
        // Present to main root View Controller
        print("signInSuccessful")
    }
}
