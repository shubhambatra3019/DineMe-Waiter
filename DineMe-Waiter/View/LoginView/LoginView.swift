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
    
    let backgroundImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "login-background")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.8
        return imageView
    }()
    
    let purpleBlurView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.primary
        view.alpha = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dineInLabel : UILabel = {
        let label = UILabel()
        label.text = "Dine In"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    let signInWithGoogleButton : GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = GIDSignInButtonStyle.wide
        button.translatesAutoresizingMaskIntoConstraints = false
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "This is an error text"
        label.textColor = UIColor.red
        label.textAlignment = .center
        
        return label
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura-Medium", size: 20)
        button.backgroundColor = Colors.primary.withAlphaComponent(0.9)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let orLabel : UILabel = {
        let orLabel = UILabel()
        orLabel.text = "or sign in with"
        orLabel.textColor = UIColor.white
        orLabel.textAlignment = .center
        orLabel.font = UIFont(name: "Futura-Medium", size: 12)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        let line = UIView()
//        line.translatesAutoresizingMaskIntoConstraints = false
//        line.backgroundColor = UIColor.white
//
//        orLabel.addSubview(line)
//        line.bottomAnchor.constraint(equalTo: orLabel.bottomAnchor).isActive = true
//        line.widthAnchor.constraint(equalTo: orLabel.widthAnchor, multiplier: 1.0).isActive = true
//        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return orLabel
    }()

    
    let signupButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = Colors.primary
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupBackgroundImageView()
        setupDineMeLabel()
        setupLoginWithEmailContainer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackgroundImageView(){
        
        addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        addSubview(purpleBlurView)
        purpleBlurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        purpleBlurView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        purpleBlurView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        purpleBlurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //Blur Effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.3
        addSubview(blurEffectView)
    }
    
    func setupDineMeLabel(){
        addSubview(dineInLabel)
        dineInLabel.translatesAutoresizingMaskIntoConstraints = false
        dineInLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        dineInLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true

    }
    
    func setupLoginWithEmailContainer(){
        let loginWithEmailStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, errorLabel,loginButton, orLabel, signInWithGoogleButton])
        
        loginWithEmailStackView.axis = .vertical
        loginWithEmailStackView.alignment = .center
        loginWithEmailStackView.distribution = .fillEqually
        loginWithEmailStackView.spacing = 30
        
        addSubview(loginWithEmailStackView)
        
        //StackView Constraints
        loginWithEmailStackView.translatesAutoresizingMaskIntoConstraints = false
        loginWithEmailStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55).isActive = true
        loginWithEmailStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        loginWithEmailStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        loginWithEmailStackView.topAnchor.constraint(equalTo: dineInLabel.bottomAnchor, constant: 130).isActive = true
        
        
        //Textfield and button Constraints
        emailTextField.widthAnchor.constraint(equalTo: loginWithEmailStackView.widthAnchor, multiplier: 1.0).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginWithEmailStackView.widthAnchor, multiplier: 1.0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginWithEmailStackView.widthAnchor, multiplier: 1.0).isActive = true
        signInWithGoogleButton.widthAnchor.constraint(equalTo: loginWithEmailStackView.widthAnchor, multiplier: 0.65).isActive = true
        
    }
}

extension UITextField{
    static func getTextField(_ string : String) -> UITextField{
        let textField = UITextField()
        textField.placeholder = string
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        textField.autocapitalizationType = .none
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
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
}

struct Colors {
    static let primary = UIColor.init(displayP3Red: 103/255, green: 118/255, blue: 214/255, alpha: 1)
}
