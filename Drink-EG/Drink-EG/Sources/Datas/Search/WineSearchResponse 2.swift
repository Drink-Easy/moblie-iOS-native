//
//  WineSearchResponse.swift
//  Drink-EG
//
//  Created by 이현주 on 8/16/24.
//

import Foundation

struct Wine: Decodable {
    let wineId: Int
    let name: String
    let imageUrl: String?
    let rating: Double
    let price: Int
}
