//
//  RatingWineViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 10/30/24.
//

import UIKit

class RatingWineViewController: UIViewController {

    let wineView = WineInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        view.addSubview(wineView)
        view.backgroundColor = UIColor(hex: "#F8F8FA")
        wineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
