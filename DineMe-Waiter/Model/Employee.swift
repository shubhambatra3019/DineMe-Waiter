//
//  Employee.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

struct Employee {
    var employeeID: String
    var employeeName: String
    var role: String
    
    init(dict: [String: Any], id: String) {
        self.employeeID = id
        self.employeeName = dict["name"] as! String
        self.role = dict["role"] as! String
    }
    
    init(employeeID: String, employeeName: String, role: String) {
        self.employeeID = employeeID
        self.employeeName = employeeName
        self.role = role
    }
    
    var documentData: [String: Any] {
        return [
            "name": employeeName,
            "role": role
        ]
    }
    
}

