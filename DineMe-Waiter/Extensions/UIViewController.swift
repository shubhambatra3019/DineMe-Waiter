//
//  UIViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showToast(toastView: UIView) {
        
        //toastView.frame = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: 250, height: 150)
        toastView.alpha = 1.0
        self.view.addSubview(toastView)
        
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        toastView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveLinear, animations: {
            toastView.alpha = 0.0
        }) { (isCompleted) in
            toastView.removeFromSuperview()
        }
        
    }
    
}

