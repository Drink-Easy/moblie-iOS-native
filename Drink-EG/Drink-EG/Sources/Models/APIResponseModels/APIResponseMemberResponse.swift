//
//  APIResponseMemberResponse.swift
//  Drink-EG
//
//  Created by 김도연 on 8/14/24.
//

import Foundation

struct APIResponseMemberResponse : Codable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : MemberResponse?
}

struct MemberResponse : Codable {
    let id : Int
    let name : String
    let username : String
    let role : String
    let isNewbie : Bool
    let monthPriceMax : Int
    let wineSort : [String]
    let wineArea : [String]
    let wineVariety : [String]
    let region : String
}
