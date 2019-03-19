//
//  User.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 07/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

struct User {
    var name: String
    var email: String
    var restaurants: [String]
    var role: String
    var shifts: [Any]
    var userId: String
    var working: Bool
    
    init(name: String, email: String, restaurants: [String] = ["2SNsflQCvsGZlblq3T9N"], role: String = "waiter", shifts: [Any] = [], userId: String, working: Bool = false) {
        self.name = name
        self.email = email
        self.restaurants = restaurants
        self.role = role
        self.shifts = shifts
        self.userId = userId
        self.working = working
    }
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as! String
        self.email = dict["email"] as! String
        self.restaurants = dict["restaurants"] as! [String]
        self.role = dict["role"] as! String
        self.shifts = dict["shifts"] as! [Any]
        self.userId = dict["userId"] as! String
        self.working = dict["working"] as! Bool
    }
    
    var documentData: [String: Any] {
    return [
    "name": name,
    "email": email,
    "restaurants": restaurants,
    "role": role,
    "shifts": shifts,
    "userId": userId,
    "working": working
    ]
    }
    
}
