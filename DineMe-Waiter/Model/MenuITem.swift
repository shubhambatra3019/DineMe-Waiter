//
//  MenuITem.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 16/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

struct MenuItem {
    
    var name: String? = ""
    var description: String? = ""
    var price: Double? = 0

    init(itemName: String, itemDescription: String, itemPrice: Double) {
        self.name = itemName
        self.description = itemDescription
        self.price = itemPrice
    }
    
    init(dict: [String : Any]) {
        self.name = dict["name"] as? String
        self.description = dict["description"] as? String
        self.price = dict["price"] as? Double
    }
    
}
