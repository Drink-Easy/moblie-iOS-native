//
//  MemberInfoRequest.swift
//  Drink-EG
//
//  Created by 김도연 on 8/13/24.
//

import Foundation

struct MemberInfoRequest : Codable {
    let userName : String
    let isNewbie : Bool
    let monthPrice : Int
    let wineSort : [String]
    let wineNation : [String]
    let wineVariety : [String]
    let region : String
    
    init(isNewbie: Bool, monthPrice: Int, wineSort: [String], wineNation: [String], wineVariety: [String], region: String, userName: String) {
        self.isNewbie = isNewbie
        self.monthPrice = monthPrice
        self.wineSort = wineSort
        self.wineNation = wineNation
        self.wineVariety = wineVariety
        self.region = region
        self.userName = userName
    }
}
