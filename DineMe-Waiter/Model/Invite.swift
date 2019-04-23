//
//  Invite.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

struct Invite {
    var accepted: Int
    var email: String
    var restaurantID: String
    var restaurantName: String
    var role: String
    var id: String
    
    init(dict: [String: Any], id:  String) {
        self.accepted = dict["accepted"] as! Int
        self.email = dict["email"] as! String
        self.restaurantID = dict["restaurantID"] as! String
        self.restaurantName = dict["restaurantName"] as! String
        self.role = dict["role"] as! String
        self.id = id
    }
}

