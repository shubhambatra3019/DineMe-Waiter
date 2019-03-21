//
//  Encodable+Decodable.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 18/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import Foundation

extension Encodable {
    var documentData: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}

extension Decodable {
    init?(dict: [String: Any]) {
        guard JSONSerialization.isValidJSONObject(dict) else {return nil}
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return nil }
        guard let newValue = try? JSONDecoder().decode(Self.self, from: jsonData) else { return nil }
        self = newValue
    }
}
