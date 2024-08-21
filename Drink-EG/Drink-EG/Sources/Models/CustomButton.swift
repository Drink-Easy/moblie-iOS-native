//
//  CustomButton.swift
//  Drink-EG
//
//  Created by 김도연 on 8/20/24.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // 버튼 타이틀 설정
        self.setTitle("내 보관함", for: .normal)
        self.setTitleColor(.gray, for: .normal)
        
        // 버튼 배경색 설정
        self.backgroundColor = .white
        
        // 버튼의 둥근 모서리 설정
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
        
        // 그림자 설정
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 버튼의 크기가 결정된 후에 그림자 경로 설정
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}
