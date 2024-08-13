//
//  MemberInfoRequest.swift
//  Drink-EG
//
//  Created by 김도연 on 8/13/24.
//

import Foundation

struct MemberInfoRequest : Codable {
    let isNewbie : Bool
    let monthPrice : Int
    let wineSort : [String]
    let wineNation : [String]
    let wineVariety : [String]
    let region : String
}
