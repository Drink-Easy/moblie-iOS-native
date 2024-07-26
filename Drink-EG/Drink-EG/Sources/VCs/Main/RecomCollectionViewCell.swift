//
//  RecomCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 7/25/24.
//

import UIKit

class RecomCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private let label: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 10)
        l.textColor = UIColor(hue: 0.1389, saturation: 0.54, brightness: 1, alpha: 1.0)
        l.numberOfLines = 0
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //레이아웃까지
    private func setupUI() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
            
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp .makeConstraints { make in
            make.leading.equalTo(imageView.snp.leading).offset(9)
            make.top.equalTo(imageView.snp.top).offset(129)
        }
        
    }
    
    func configure(imageName: String) {
        if let image = UIImage(named: imageName) {
            label.text = imageName
            imageView.image = image
        }
    }
}
