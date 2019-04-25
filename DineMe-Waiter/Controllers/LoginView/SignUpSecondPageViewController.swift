//
//  SignUpSecondPageViewController.swift
//  DineMe-Waiter
//
//  Created by Anthony Lee on 4/1/19.
//  Copyright © 2019 Esper. All rights reserved.
//
import UIKit
import Firebase

class SignUpSecondPageViewController: UIViewController{
    
    let db = Firestore.firestore()

    
    //Setup View
    lazy var signUpView : SignUpView = {
        let signUpView = SignUpView()
        signUpView.signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapped))
        tap.cancelsTouchesInView = false
        signUpView.addGestureRecognizer(tap)
        return signUpView
    }()
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Sign Up"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleTapped(){
        view.endEditing(true)
    }
    
    @objc func handleCancel(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSignUp(){
        
        guard let email = signUpView.email ,let password = signUpView.passwordTextField.text ,let rePassword = signUpView.reEnterPasswordTextField.text,let firstName = signUpView.firstNameTextField.text,let lastName = signUpView.lastNameTextField.text, allFieldsFull() else {
            self.signUpView.errorLabel.text = "All fields must be full"
            return
        }
        
        guard password == rePassword else {
            self.signUpView.errorLabel.text = "Passwords do not match"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (authDataResult, error) in
            guard let authDataResult = authDataResult else {
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code){
                        switch (errCode){
                        case .missingEmail:
                            self.signUpView.errorLabel.text = "An email address must be provided"
                        case .invalidEmail:
                            self.signUpView.errorLabel.text = "Invalid email"
                        case .emailAlreadyInUse:
                            self.signUpView.errorLabel.text = "Email already in use"
                        case .weakPassword:
                            self.signUpView.errorLabel.text = "Password is weak. Try a longer password"
                        default:
                            self.signUpView.errorLabel.text = "An error has occured. Please try again"
                        }
                    }
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            
            // TODO: if successful signup, Add user to the firebase database
            
//            let newUser = UPoolUser(email: email, fn: firstName, ln: lastName, uid: authDataResult.user.uid, fcmToken: fcmToken)
//            //Add user to the Firebase database
//        self.db.collection(FirebaseDatabaseKeys.usersKey).document(authDataResult.user.uid).setData(newUser.dictionary, completion: { (err) in
//
//            })
        })
    }
    
    private func allFieldsFull() -> Bool{
        if signUpView.passwordTextField.text == ""{
            return false
        } else if signUpView.reEnterPasswordTextField.text == ""{
            return false
        } else if signUpView.firstNameTextField.text == ""{
            return false
        } else if signUpView.lastNameTextField.text == ""{
            return false
        } else {
            return true
        }
    }
}
