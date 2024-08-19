//
//  NoteCollectionViewCell.swift
//  Drink-EG
//
//  Created by 김도연 on 8/20/24.
//

import Foundation
import UIKit
import SnapKit
import Moya

class NoteCollectionViewCell: UICollectionViewCell { // 셀에 이미지와 label을 추가하기 위한 커스텀 셀
    
    let imageView = UIImageView() // CollectionView에 image와 label 추가
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
