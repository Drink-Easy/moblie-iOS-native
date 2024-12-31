//
//  WineData.swift
//  Drink-EG
//
//  Created by 김도연 on 12/31/24.
//

import Foundation
import SwiftData

@Model
class WineData {
    var wineId : Int
    var imageUrl : String
    var wineName : String
    var sort : String
    var price : Int
    var vivinoRating : Double
    
    init(wineId: Int, imageUrl: String, wineName: String, sort: String, price: Int, vivinoRating: Double) {
        self.wineId = wineId
        self.imageUrl = imageUrl
        self.wineName = wineName
        self.sort = sort
        self.price = price
        self.vivinoRating = vivinoRating
    }
}

var modelContainer : ModelContainer =  {
    let schema = Schema([WineData.self])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
        let container = try ModelContainer(for: schema, configurations: [config])
        return container
    } catch {
        fatalError("ModelContainer 생성 실패!!!: \(error)")
    }
}()
