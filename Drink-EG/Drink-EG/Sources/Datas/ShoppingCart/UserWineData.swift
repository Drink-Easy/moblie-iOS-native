//
//  UserWineData.swift
//  Drink-EG
//
//  Created by 김도연 on 8/17/24.
//

import Foundation

class UserWineData {
    let wine : Wine
    var shop : ShopData
    
    init(wine: Wine, shop: ShopData) {
        self.wine = wine
        self.shop = shop
    }
}

class ShoppingObject {
    var count : Int
    var wineData : UserWineData
    
    init(count: Int = 1, wineData: UserWineData) {
        self.count = count
        self.wineData = wineData
    }
}

struct ShopData {
    let name: String
    let address : String
    let distanceToUser : Double
    let price: Int
}
