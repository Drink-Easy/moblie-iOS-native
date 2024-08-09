//
//  ModalViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/9/24.
//

import Foundation
import UIKit
import SnapKit

class ModalViewController: UIViewController {
    
    var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.medium(), .large()]  // modal이 일부분만 차지하게 함
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = true  // 상단에 드래그바 표시
        }
    }
    
    
}
