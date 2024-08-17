//
//  WineInfoResponse.swift
//  Drink-EG
//
//  Created by 이현주 on 8/16/24.
//

import Foundation

struct WineInfo: Decodable {
    let wineId: Int
    let name: String
    let imageUrl: String?
    let price: Int
    let sort: String
    let area: String
    let sugarContent: Int
    let acidity: Int
    let tannin: Int
    let body: Int
    let alcohol: Int
    let scentAroma: [String]
    let scentTaste: [String]
    let scentFinish: [String]
    let rating: Double
}
