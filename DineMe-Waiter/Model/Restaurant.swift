//
//  Restaurant.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 23/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

struct Restaurant {
    var name: String
    var restaurantID: String
    
    init(dict: [String: Any], resID: String) {
        self.name = dict["name"] as! String
        self.restaurantID = resID
    }
}
