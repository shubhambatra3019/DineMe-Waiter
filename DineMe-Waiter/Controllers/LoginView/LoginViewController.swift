//
//  ViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 01/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import GoogleSignIn


class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    //Login View
    lazy var loginView: LoginView = {
        let view = LoginView()
        view.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        view.signupButton.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return view
    }()
    
    override func loadView() {
        view = loginView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        if UserDefaults.standard.object(forKey: "user") == nil {
            print("Not Logged in")
        }
        else {
            presentOngoingTablesPage()
        }
    }
    
    @objc func handleLogin(){
        let email = loginView.emailTextField.text
        let password = loginView.passwordTextField.text
        
        guard email != "" && password != "" else{
            self.loginView.errorLabel.text = "Empty email/password field"
            return
        }
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (authResult, error) in
            
            guard let authResult = authResult else {
                
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code){
                        print("The error is \(error.localizedDescription)")
                        switch (errCode){
                        case .userNotFound:
                            self.loginView.errorLabel.text = "User account not found"
                        case .wrongPassword:
                            self.loginView.errorLabel.text = "Incorrect password"
                        case .invalidEmail:
                            self.loginView.errorLabel.text = "Invalid email"
                        default:
                            self.loginView.errorLabel.text = "An error has occured. Please try again"
                        }
                    }
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            
            guard authResult.user.isEmailVerified == true else {
                self.loginView.errorLabel.text = "Account not verified. Please check your email for verification"
                return
            }
            
            print(authResult.user)
            let newUser = User(name: authResult.user.displayName ?? "", email: authResult.user.email!, userId: authResult.user.uid)
            UserDefaults.standard.set(newUser.documentData, forKey: "user")
            
            let ongoingTablesVC = OngoingTablesViewController()
            self.present(ongoingTablesVC, animated: true, completion: nil)
        })
    }
    
    @objc func handleSignup(){
        let signUpFirstPageVC = SignUpFirstPageViewController()
        let navVC = UINavigationController(rootViewController: signUpFirstPageVC)
        present(navVC, animated: true, completion: nil)
    }
    
    @objc func handleTapToDismissKeyboard(){
        view.endEditing(true)
    }
    
    func presentOngoingTablesPage() {
        let ongoingTablesVC = OngoingTablesViewController()
        present(ongoingTablesVC, animated: true, completion: nil)
    }
}
