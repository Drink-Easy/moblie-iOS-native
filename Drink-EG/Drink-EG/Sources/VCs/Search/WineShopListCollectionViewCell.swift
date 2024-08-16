//
//  WineShopListCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 8/14/24.
//

import UIKit
import SnapKit

class WineShopListCollectionViewCell: UICollectionViewCell {
    
    let shopName: UILabel = {
        let l1 = UILabel()
        l1.font = .boldSystemFont(ofSize: 18)
        l1.textColor = .black
        l1.numberOfLines = 0
        return l1
    }()
    
    private let distance: UILabel = {
        let l2 = UILabel()
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "icon_location")
        
        let imageOffsetY: CGFloat = -2.0 // 텍스트와 이미지의 정렬을 맞추기 위해 조정합니다.
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 10, height: 14) // 이미지의 크기를 설정합니다.
        
        let completeText = NSMutableAttributedString(string: "")
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        completeText.append(attachmentString)

        // 매장 텍스트 추가
        let text = NSAttributedString(string: " 2.3 km", attributes: [.font: UIFont.boldSystemFont(ofSize: 12)])
        completeText.append(text)
        l2.attributedText = completeText
        l2.textColor = UIColor(hex: "#FF7A6D")
        return l2
    }()
    
    private let address: UILabel = {
        let l3 = UILabel()
        l3.text = "서울특별시 마포구 와우산로 94"
        l3.textColor = UIColor(hex: "#767676")
        l3.font = UIFont.boldSystemFont(ofSize: 14)
        return l3
    }()
    
    let price: UILabel = {
        let l4 = UILabel()
        l4.text = "25,000 ₩"
        l4.textColor = UIColor(hex: "#767676")
        l4.font = UIFont.boldSystemFont(ofSize: 12)
        return l4
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.contentView.addSubview(shopName)
        self.contentView.addSubview(distance)
        self.contentView.addSubview(address)
        self.contentView.addSubview(price)
        self.contentView.backgroundColor = UIColor(hex: "EDEDED")
        self.contentView.layer.borderWidth = 1.5
        self.contentView.layer.borderColor = UIColor(hex: "D9D9D9")?.cgColor
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
  
        shopName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(17)
        }
        
        distance.snp.makeConstraints { make in
            make.centerY.equalTo(shopName)
            make.leading.equalTo(shopName.snp.trailing).offset(13)
        }
        
        address.snp.makeConstraints { make in
            make.top.equalTo(shopName.snp.bottom).offset(13)
            make.leading.equalTo(shopName)
        }
        
        price.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(13)
            make.trailing.equalToSuperview().inset(17)
        }
    }
    
    func configure(name: String) {
        self.shopName.text = name
    }
}
