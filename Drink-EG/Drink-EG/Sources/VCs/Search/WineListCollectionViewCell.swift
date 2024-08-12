//
//  WineListCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 8/10/24.
//

import UIKit

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
    
    func configure(imageName: String) {
        if let image = UIImage(named: imageName) {
            self.name.text = imageName
            price.text = "165,000 ₩"
            score.text = "4.5"
            imageView.image = image
        }
    }
}
