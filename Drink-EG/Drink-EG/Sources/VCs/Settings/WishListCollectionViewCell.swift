//
//  WishListCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 8/22/24.
//

import UIKit
import SnapKit
import SDWebImage

protocol WishListCollectionViewCellDelegate: AnyObject {
    func wishDeleteButtonTapped(on cell: WishListCollectionViewCell)
}

class WishListCollectionViewCell: UICollectionViewCell {
    weak var delegate: WishListCollectionViewCellDelegate?
    
    private let likeImage = UIImage(named: "icon_like_fill")
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
    
    private let deleteButton: UIButton = {
        let b = UIButton(type: .system)
        let symbolName = "xmark"  // 사용할 시스템 이미지 이름
        let configuration = UIImage.SymbolConfiguration(weight: .semibold)  // 굵기 설정
        let image = UIImage(systemName: symbolName, withConfiguration: configuration)
        b.setImage(image, for: .normal)
        b.tintColor = UIColor(hex: "999999")
        b.backgroundColor = .clear
        b.addTarget(self, action: #selector(wishDeleteButtonTapped), for: .touchUpInside)
        return b
    }()
    
    @objc private func wishDeleteButtonTapped() {
        delegate?.wishDeleteButtonTapped(on: self) // 델리게이트 호출
    }
    
    private func configureLikeButton() {
        likeButton.setImage(likeImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.backgroundColor = .clear
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
        self.contentView.addSubview(likeButton)
        self.contentView.addSubview(deleteButton)
        self.contentView.backgroundColor = UIColor(hex: "D0D0D0")
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
  
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(imageView.snp.height)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(7)
            make.trailing.equalToSuperview().inset(9)
            make.width.height.equalTo(20)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalTo(likeButton)
            make.width.height.equalTo(15)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(imageView.snp.trailing).offset(18)
            if traitCollection.userInterfaceIdiom == .pad {
                make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
            } else {
                make.width.lessThanOrEqualTo(220)
            }
            make.height.lessThanOrEqualTo(55)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(3)
            make.leading.equalTo(name)
        }
    }
    
    func configure(wine: Wine) {
        let imageURL = URL(string: wine.imageUrl!)
        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        name.text = wine.name
        let priceString: String = String(wine.price)
        price.text = priceString
    }
}
