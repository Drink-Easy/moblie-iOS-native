//
//  WineListCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 8/10/24.
//

import UIKit
import SnapKit
import SDWebImage

class WineListCollectionViewCell: UICollectionViewCell {
    
    private let likeImage = UIImage(named: "icon_like_fill")
    private let nlikeImage = UIImage(named: "icon_like_nfill")
    let likeButton = UIButton(type: .custom)
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let name: UILabel = {
        let l1 = UILabel()
        l1.font = .boldSystemFont(ofSize: 18)
        l1.textColor = .black
        l1.numberOfLines = 0
        l1.adjustsFontSizeToFitWidth = true // 텍스트가 레이블 너비에 맞도록 크기 조정
        l1.minimumScaleFactor = 0.5
        return l1
    }()
    
    private let price: UILabel = {
        let l2 = UILabel()
        l2.font = .boldSystemFont(ofSize: 14)
        l2.textColor = UIColor(hex: "#767676")
        return l2
    }()
    
    private let score: UILabel = {
        let l3 = UILabel()
        l3.font = .boldSystemFont(ofSize: 11)
        l3.textColor = UIColor(hex: "#767676")
        return l3
    }()
    
    private func configureLikeButton() {
        likeButton.setImage(nlikeImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.backgroundColor = .clear
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        // Bool 값 toggle
        sender.isSelected.toggle()
            
        // 버튼이 클릭될 때마다, 버튼 이미지를 변환
        if sender.isSelected {
            sender.setImage(likeImage?.withRenderingMode(.alwaysOriginal), for: .selected)
        } else {
            sender.setImage(nlikeImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
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
        configureLikeButton()
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(name)
        self.contentView.addSubview(price)
        self.contentView.addSubview(score)
        self.contentView.addSubview(likeButton)
        self.contentView.backgroundColor = UIColor(hex: "D0D0D0")
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
  
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(imageView.snp.height)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(imageView.snp.trailing).offset(18)
            make.width.lessThanOrEqualTo(220)
            make.height.lessThanOrEqualTo(55)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(3)
            make.leading.equalTo(name)
        }
        
        score.snp.makeConstraints { make in
            make.top.equalTo(name)
            make.trailing.equalToSuperview().inset(11)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(7)
            make.trailing.equalToSuperview().inset(9)
            make.width.height.equalTo(20)
        }
    }
    
    func configure(wine: Wine) {
        let imageURL = URL(string: wine.imageUrl!)
        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        name.text = wine.name
        let priceString: String = String(wine.price)
        price.text = priceString
        let scoreString: String = String(wine.rating)
        score.text = scoreString
    }
}
