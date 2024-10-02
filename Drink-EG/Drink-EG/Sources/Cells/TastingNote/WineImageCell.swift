//
//  WineImageCell.swift
//  Drink-EG
//
//  Created by 이수현 on 9/28/24.
//

import Foundation
import UIKit
import SnapKit

class WineImageCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.layer.cornerRadius = 14
        return i
    }()
    
    private let label: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "Pretendard-Medium", size: 12)
        l.textColor = .black
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width) // 이미지뷰의 높이를 너비와 동일하게 설정
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with model: ImageCollectionView, index: Int) {
        guard index < model.images.count, index < model.label.count else {
            return // 배열 인덱스 범위 벗어나는 경우 처리
        }
        
        imageView.image = UIImage(named: model.images[index])
        label.text = model.label[index]
    }
    
}
