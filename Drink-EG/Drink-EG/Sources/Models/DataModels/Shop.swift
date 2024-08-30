//
//  Shop.swift
//  Drink-EG
//
//  Created by 김도연 on 8/27/24.
//

import UIKit
import RealmSwift

class Shop: Object {
    @Persisted var name: String
    @Persisted var address: String
    @Persisted var distanceToUser: Double
    @Persisted var price: Int

    convenience init(name: String, address: String, distanceToUser: Double, price: Int) {
        self.init()
        self.name = name
        self.address = address
        self.distanceToUser = distanceToUser
        self.price = price
    }
}
