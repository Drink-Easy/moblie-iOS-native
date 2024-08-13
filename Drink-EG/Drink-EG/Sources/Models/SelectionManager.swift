//
//  SelectionManager.swift
//  Drink-EG
//
//  Created by 김도연 on 8/14/24.
//

import Foundation

class SelectionManager {
    static let shared = SelectionManager()
    
    var isNewbie : Bool = false
    var monthPrice : Int = 0
    var userName : String = ""
    
    var wineSort : [String] = []
    var wineNation : [String] = []
    var wineVariety : [String] = []
    
    private init() {}
    
    func setNewbie(answer : Bool) {
        isNewbie = answer
    }
    
    func setPrice(answer : Int) {
        monthPrice = answer
    }
    
    func setName(answer : String) {
        userName = answer
    }
    
    func setWineSort(answer : [String]) {
        wineSort = answer
    }
    
    func setWineNation(anser: [String]) {
        wineNation = anser
    }
    
    func setWineVariety(anser: [String]) {
        wineVariety = anser
    }
    
//    func setWine(answer : )
}
