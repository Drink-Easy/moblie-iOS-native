//
//  ShoppingListManager.swift
//  Drink-EG
//
//  Created by 김도연 on 8/17/24.
//

import Foundation

class ShoppingListManager {
    // Singleton 처리
    static let shared = ShoppingListManager()
    private init() { }
    
    var myCartWines : [ShoppingObject] = []
    
    /// 장바구니 페이지에서 수량 변경 시 호출
    /// 검색 > 판매처 페이지에서 담기 버튼 누르면 호출
    /// addCount에 디폴트 값 1
    func addNewWine(_ data : UserWineData, _ addCount: Int = 1) {
        if let index = isExistingInList(data.wine.name, in: data.shop.name) {
            myCartWines[index].count += addCount
        } else {
            myCartWines.append(ShoppingObject(count: addCount, wineData: data))
        }
    }
    
    /// 장바구니 페이지에서 선택 삭제, 전체 삭제 등 버튼 누르면 호출
    func deleteWine(_ data: ShoppingObject) {
        if let index = isExistingInList(data.wineData.wine.name, in: data.wineData.shop.name) {
            myCartWines.remove(at: index)
        }
    }
    
    /// 판매처 변경 시 호출
    func updatePlace(_ data: ShoppingObject) {
        if let index = isExistingWineInList(data.wineData.wine.name) {
            myCartWines[index].wineData.shop = data.wineData.shop
        }
    }
    
    /// 담아두기 목록에 와인, 판매처 정보로 찾아서 인덱스 반환
    private func isExistingInList(_ name: String, in shopName : String) -> Int? {
        for (idx, data) in myCartWines.enumerated() {
            if data.wineData.wine.name == name && data.wineData.shop.name == shopName {
                return idx
            }
        }
        return nil
    }
    
    /// 담아두기 목록에 와인 정보로 찾아서 인덱스 반환
    /// 판매처 변경 시 호출됨
    private func isExistingWineInList(_ name: String) -> Int? {
        for (idx, data) in myCartWines.enumerated() {
            if data.wineData.wine.name == name {
                return idx
            }
        }
        return nil
    }
    
}
