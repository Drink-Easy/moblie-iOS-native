//
//  ReviewListCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 8/15/24.
//

import UIKit
import SnapKit

class ReviewListCollectionViewCell: UICollectionViewCell {
    
    var score: Double = 0.0
    private let scoreLabel = UILabel()
    
    private let name: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 16)
        l.textColor = .black
        l.numberOfLines = 1 // 한 줄로 표시
        l.adjustsFontSizeToFitWidth = true // 텍스트가 레이블 너비에 맞도록 크기 조정
        l.minimumScaleFactor = 0.5 // 텍스트 크기가 최소 50% 까지 줄어들 수 있음
        return l
    }()
    
    private let stick: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "#FA735B")
        return v
    }()
    
    private let content: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 12)
        l.textColor = UIColor(hex: "767676")
        l.text = "맛있어요."
        l.numberOfLines = 0
        return l
    }()
    
    private func configureScore() {
        scoreLabel.text = "★ \(score)"
        scoreLabel.font = .boldSystemFont(ofSize: 14)
        scoreLabel.textColor = UIColor(hex: "#FB5133")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //레이아웃까지
    private func setupUI() {
        configureScore()
        
        self.contentView.addSubview(name)
        self.contentView.addSubview(stick)
        self.contentView.addSubview(scoreLabel)
        self.contentView.addSubview(content)
        self.contentView.backgroundColor = UIColor(hex: "F8F8FA")
        self.contentView.layer.borderWidth = 0
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        stick.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview().offset(94)
            make.width.equalTo(1)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalTo(contentView.snp.leading).offset(47)
            make.width.lessThanOrEqualTo(70)
        }
        
        content.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalTo(stick.snp.trailing).offset(22)
            make.width.lessThanOrEqualTo(234)
            make.height.lessThanOrEqualTo(88)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(14)
            make.centerX.equalTo(name)
        }
    }
    
    func configure(review: WineReview) {
        
        print("Satisfaction: \(review.satisfaction)")
        
        self.name.text = review.name
        self.score = review.satisfaction
        self.content.text = review.review
        
        configureScore()
    }
}
