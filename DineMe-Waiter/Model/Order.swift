//
//  Order.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 11/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

struct Order{
    var table: String
    var completed: Bool
    var creationDateTime: Date
    var items: [OrderItem]
    var restaurantID: String
    var waiterID: String
    var managerID: String
    var paidDateTime: Date
    var orderID: String
    var partySize: Int
    
    init(table: String, completed: Bool, creationDateTime: Date = Date(), items: [OrderItem] = [], restaurantID: String, waiterID: String, managerID: String = "abcd", paidDateTime: Date, orderID: String, partySize: Int) {
        self.table = table
        self.completed = completed
        self.creationDateTime = creationDateTime
        self.items = items
        self.restaurantID = restaurantID
        self.waiterID = waiterID
        self.managerID = managerID
        self.paidDateTime = paidDateTime
        self.orderID = orderID
        self.partySize = partySize
    }
    
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
        self.orderID = dict["orderID"] as! String
        self.partySize = dict["partySize"] as! Int
    }
    
    var documentData: [String: Any] {
        return [
        "table": table,
        "completed": completed,
        "creationDateTime": creationDateTime,
        "items": items,
        "restaurantID": restaurantID,
        "waiterID": waiterID,
        "managerID": managerID,
        "paidDateTime": paidDateTime,
        "orderID" : orderID,
        "partySize": partySize
        ]
    }
    
}
