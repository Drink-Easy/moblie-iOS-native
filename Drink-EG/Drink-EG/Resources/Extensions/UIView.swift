//
//  UIView.swift
//  Drink-EG
//
//  Created by 김도연 on 8/20/24.
//

import UIKit

extension UIView {
    
    func applyTopShadow(shadowColor: UIColor = .black, shadowOpacity: Float = 0.25, shadowRadius: CGFloat = 5, shadowOffset: CGSize = CGSize(width: 0, height: -3)) {
        // 그림자 색상
        self.layer.shadowColor = shadowColor.cgColor
        
        // 그림자 투명도
        self.layer.shadowOpacity = shadowOpacity
        
        // 그림자 퍼짐 정도
        self.layer.shadowRadius = shadowRadius
        
        // 그림자 오프셋 (상단에만 그림자가 보이도록 설정)
        self.layer.shadowOffset = shadowOffset

        // 레이아웃이 완료된 후에 shadowPath 설정
        DispatchQueue.main.async {
            let shadowPath = UIBezierPath()
            shadowPath.move(to: CGPoint(x: 0, y: 0))
            shadowPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
            shadowPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height / 4))
            shadowPath.addLine(to: CGPoint(x: 0, y: self.bounds.height / 4))
            shadowPath.close()
            
            self.layer.shadowPath = shadowPath.cgPath
        }
    }
}
