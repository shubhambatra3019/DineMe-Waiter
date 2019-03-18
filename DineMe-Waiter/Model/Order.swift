//
//  Order.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 11/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

struct Order {
    var table: String
    var completed: Bool
    var creationDateTime: Date
    var items: [OrderItem]
    var restaurantID: String
    var waiterID: String
    var managerID: String
    var paidDateTime: Date
    
    init(dict: [String: Any]) {
        self.table = dict["table"] as! String
        self.completed = dict["completed"] as! Bool
        self.creationDateTime = dict["creationDateTime"] as! Date
        self.items = []
        let itemsArr = dict["items"] as! [[String: Any]]
        for item in itemsArr {
            self.items.append(OrderItem(dict: item))
        }
        self.restaurantID = dict["restaurantID"] as! String
        self.waiterID = dict["waiterID"] as! String
        self.managerID = dict["managerID"] as! String
        self.paidDateTime = dict["paidDateTime"] as! Date
    }
    
    /*var documentData: [String: Any] {
     
    }*/
    
}
