//
//  HomeResponse.swift
//  Drink-EG
//
//  Created by 김도연 on 8/17/24.
//

import Foundation

struct HomeResponse : Codable {
    let name : String
    let recommendWineDTOs : [RecommendWineResponse]
}
