//
//  WineClassMainViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit
import SwiftUI


class WineClassMainViewController : UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    private func setUI() {
        let cardSliderView = ContentView()
        let hostingController = UIHostingController(rootView: cardSliderView)
        
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.snp.makeConstraints { make in
            make.center.equalToSuperview() // 화면 정중앙에 배치
            make.width.equalToSuperview().multipliedBy(0.8) // 부모 뷰의 80% 너비
            make.height.equalToSuperview().multipliedBy(0.8) // 부모 뷰의 50% 높이
        }
    }
}
