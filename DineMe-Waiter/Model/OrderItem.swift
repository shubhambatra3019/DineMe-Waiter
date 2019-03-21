//
//  OrderItem.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 25/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

struct OrderItem {
    
    var itemName: String
    var itemQuantity: Int
    var itemPrice: Double
    var itemNote: String
    
    init(itemName: String, itemQuantity: Int, itemPrice: Double, itemNote: String = "") {
        self.itemName = itemName
        self.itemQuantity = itemQuantity
        self.itemPrice = itemPrice
        self.itemNote = itemNote
    }
    
    init(dict: [String: Any]) {
        self.itemName = dict["name"] as! String
        self.itemQuantity = dict["quantity"] as! Int
        self.itemPrice = dict["unit_price"] as! Double
        self.itemNote = ""
    }
    
}
