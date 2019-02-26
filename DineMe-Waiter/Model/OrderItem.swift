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
    
    init(itemName: String, itemQuantity: Int, itemPrice: Double) {
        self.itemName = itemName
        self.itemQuantity = itemQuantity
        self.itemPrice = itemPrice
    }
    
}
