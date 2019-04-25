//
//  LoginView.swift
//  DineMe-Waiter
//
//  Created by Anthony Lee on 3/22/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginView : UIView {
    
    let dineInLabel : UILabel = {
        let label = UILabel()
        label.text = "Dine In"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    let signInWithGoogleButton : GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = GIDSignInButtonStyle.wide
        return button
    }()
    
    //The container view that has the email/password textfield and login, signup button
    let loginWithEmailContainerView = UIView()
    
    let emailTextField : UITextField = {
        let txtField = UITextField.getTextField("Email")
        return txtField
    }()
    
    let passwordTextField : UITextField = {
        let txtField = UITextField.getTextField("Password")
        txtField.isSecureTextEntry = true
        return txtField
    }()
    
    let errorLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "This is an error text"
        label.textColor = UIColor.red
        label.textAlignment = .center
        return label
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.gray
        return button
    }()
    
    let signupButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.gray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupDineMeLabel()
        setupLoginWithEmailContainer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDineMeLabel(){
        addSubview(dineInLabel)
        dineInLabel.translatesAutoresizingMaskIntoConstraints = false
        dineInLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        dineInLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true

    }
    
    func setupLoginWithEmailContainer(){
        let loginAndSignupButtonStackView = UIStackView(arrangedSubviews: [loginButton, signupButton])
        loginAndSignupButtonStackView.axis = .horizontal
        loginAndSignupButtonStackView.spacing = 10
        loginAndSignupButtonStackView.distribution = .fillEqually
        
        let loginWithEmailStackView = UIStackView(arrangedSubviews: [signInWithGoogleButton ,emailTextField, passwordTextField, errorLabel,loginAndSignupButtonStackView])
        loginWithEmailStackView.axis = .vertical
        loginWithEmailStackView.distribution = .fillEqually
        loginWithEmailStackView.spacing = 30
        
        addSubview(loginWithEmailStackView)
        
        //StackView Constraints
        loginWithEmailStackView.translatesAutoresizingMaskIntoConstraints = false
        loginWithEmailStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        loginWithEmailStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        loginWithEmailStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        loginWithEmailStackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        
//        let topLine = UIView()
//        loginWithEmailStackView.addSubview(topLine)
//        topLine.addGrayBorderTo(view: loginWithEmailStackView, multiplier: 1.0, bottom: false, centered: true, color: UIColor.gray)
        
    }
}

extension UITextField{
    static func getTextField(_ string : String) -> UITextField{
        let textField = UITextField()
        textField.placeholder = string
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = UIColor.white
        textField.autocapitalizationType = .none
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }
}

extension UIView{
    static func dropShadow(view : UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 4.0
        view.layer.cornerRadius = 5.0
    }
    
    func addGrayBorderTo(view: UIView, multiplier: CGFloat, bottom:Bool, centered: Bool, color: UIColor){
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if bottom{
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        if centered {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        }
        self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
        self.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
