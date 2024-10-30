//
//  WineInfoViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 10/30/24.
//

import UIKit

class WineInfoViewController: UIViewController {

    let wineView = WineInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        wineView.addSubview(view)
    }
    

}
