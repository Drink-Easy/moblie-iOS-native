//
//  WineClassCell.swift
//  Drink-EG
//
//  Created by 김도연 on 8/20/24.
//

import UIKit

class WineClassCell: UICollectionViewCell {
    static let reuseIdentifier = "WineClassCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.layer.cornerRadius = UIConstants.cellCornerRadius
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = UIConstants.cellShadowOpacity
        contentView.layer.shadowOffset = UIConstants.cellShadowOffset
        contentView.layer.shadowRadius = UIConstants.cellShadowRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
}
