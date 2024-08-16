//
//  WineClassMainViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit

struct Item: CardSliderItem {
    var image: UIImage
    var rating: Int?
    var title: String
    var subtitle: String?
    var description: String?
}

class WineClassMainViewController : CardSliderViewController, CardSliderDataSource {
    var datas = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datas.append(Item(image: UIImage(named: "ClassSampleImage")!, title: "First Wine Class"))
        datas.append(Item(image: UIImage(named: "ClassSampleImage")!, title: "Second Wine Class"))
        datas.append(Item(image: UIImage(named: "ClassSampleImage")!, title: "Third Wine Class"))
    
        view.backgroundColor = .white
        
        self.dataSource = self
        
    }
    
    func item(for index: Int) -> any CardSliderItem {
        datas[index]
    }
    
    func numberOfItems() -> Int {
        datas.count
    }
    
}
