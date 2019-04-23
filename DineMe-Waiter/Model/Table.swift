//
//  Table.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 18/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

struct Table {
    var available: Bool
    var seats: Int
    var tableName: Int
    
    init(dict: [String: Any]) {
        self.available = dict["available"] as! Bool
        self.seats = dict["seats"] as! Int
        self.tableName = dict["tableName"] as! Int
    }

    
}
