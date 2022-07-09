//
//  Item.swift
//  ShoppingList
//
//  Created by Marina Basaeva on 7/9/22.
//

import Foundation

class Item: Codable {
    var name: String
    var isComlete: Bool
    
    init(name: String, isComplete: Bool) {
        self.name = name
        self.isComlete = isComplete
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.name == rhs.name
    }
}
