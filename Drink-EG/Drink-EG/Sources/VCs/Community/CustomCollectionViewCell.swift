//
//  CustomCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이수현 on 8/7/24.
//

import Foundation
import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()
    let detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(detailLabel)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        detailLabel.textColor = UIColor(hex: "FF8585")
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        contentView.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.leading.equalTo(contentView.snp.leading).offset(13)
        }
        
        subtitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        imageView.snp.makeConstraints{ make in
            make.top.bottom.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.trailing)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.3) 
        }
        
        detailLabel.snp.makeConstraints{ make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(23)
            make.leading.equalTo(subtitleLabel.snp.leading)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, subtitle: String, detail: String, imageName: String) {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            detailLabel.text = detail
            imageView.image = UIImage(named: imageName)
        }
}
