//
//  StartLoginCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 7/30/24.
//

import UIKit

class StartLoginCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let label1: UILabel = {
        let l1 = UILabel()
        l1.font = .systemFont(ofSize: 32, weight: .bold)
        l1.textColor = .white
        l1.textAlignment = .center
        l1.numberOfLines = 0
        return l1
    }()
    
    private let label2: UILabel = {
        let l2 = UILabel()
        l2.font = .systemFont(ofSize: 14, weight: .bold)
        l2.textColor = .white
        l2.textAlignment = .center
        l2.numberOfLines = 0
        return l2
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label1)
        self.contentView.addSubview(label2)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(50)
            make.centerX.equalToSuperview()
            //make.width.equalTo(325)
            //make.height.equalTo(300)
        }
        
        label1.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func configure(imageName: String, label1: String, label2: String) {
        if let image = UIImage(named: imageName) {
            imageView.image = image
        }
        self.label1.text = label1
        self.label2.text = label2
    }
    
}
