//
//  MenuITem.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 16/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

struct MenuItem {
    
    var itemName: String
    var itemDescription: String
    var itemPrice: Double

    init(itemName: String, itemDescription: String, itemPrice: Double) {
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.itemPrice = itemPrice
    }
    
}
